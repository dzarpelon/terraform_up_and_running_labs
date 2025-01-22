# define provider and region
provider "aws" {
  region = "us-east-2"
}

# create single instance in aws
resource "aws_instance" "example" {
  ami = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
}
