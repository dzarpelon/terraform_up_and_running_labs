provider "aws" {
    region = "us-east-2"
}

#make terraform use the remote s3 bucket for the state file

terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-dzarpelon"
    key = "global/s3/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "terraform-up-and-running-locks-dzarpelon"
    encrypt = true
  }
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

# Block all public access to the bucket

resource "aws_s3_account_public_access_block" "public_access" {
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
  }

  # deploy Dynamo DB for locking
  resource "aws_dynamodb_table" "terraform_locks" {
    name = "terraform-up-and-running-locks-dzarpelon"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
      name = "LockID"
      type = "S"
    }
  }