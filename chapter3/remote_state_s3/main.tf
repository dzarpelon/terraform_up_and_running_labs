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