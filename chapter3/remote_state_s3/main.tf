provider "aws" {
    region = "us-east-2"
}

# create s3 bucket for the tfstate file
resource "aws_s3_bucket" "terraform_state" {
  #remember bucket names need to be GLOBALLY unique on AWS
  bucket = "terraform-up-and-running-state-dzarpelon"
  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }
}

#Enable versioning of the file so full revision history of state files is possible

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server side encryption by default

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}