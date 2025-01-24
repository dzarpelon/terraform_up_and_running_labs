provider "aws" {
  region = "us-east-2"
}

#configure the module to store its state on the s3 bucket

terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-dzarpelon"
    key = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "terraform-up-and-running-locks-dzarpelon"
    encrypt = true
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t3.micro"
  skip_final_snapshot = true
  db_name = "example_database"
  #make sure to not put any type of secrets on the file! remember tfstate is plaintext. One way to avoid that is to use variables:
  username = var.db_username
  password = var.db_password
  # The value of those vars will be set using env variables as "export TF_VAR_db_username=value" and "export TF_VAR_db_password=value"
}