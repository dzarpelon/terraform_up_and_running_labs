# define provider and region
provider "aws" {
  region = "us-east-2"
}

# create single instance in aws
resource "aws_instance" "example" {
  ami = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
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

