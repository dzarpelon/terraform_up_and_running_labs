terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-dzarpelon"
    key = "workspaces-example/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "terraform-up-and-running-locks-dzarpelon"
    encrypt = true
  }
}

resource "aws_instance" "example" {
  ami = "ami-0fb653ca2d3203ac1"
  # conditionally set the instance type depending on which workspace it is running. If it's the default workspace, use t2.medium else use t2.micro
  instance_type = terraform.workspace == "default" ? "t2.medium" :"t2.micro"
}