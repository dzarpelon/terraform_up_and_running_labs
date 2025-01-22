# define provider and region
provider "aws" {
  region = "us-east-2"
}

# create single instance in aws
resource "aws_instance" "example" {
  ami = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  # make the instance part of the vpc securit group
  vpc_security_group_ids = [aws_security_group.instance.id]
  # run script to add data to index.html
  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p 8080 &
    EOF
  user_data_replace_on_change = true
#add tag to name the resource
tags = {
  name = "terraform-example"
}
}

# create security group to allo port 8080

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}
