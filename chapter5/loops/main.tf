provider "aws" {
  region = "us-east-2"
}

resource "aws_iam_user" "example" {
  ## for a single user, we would use the following:
  #name = "neo"
  ## as we want multiple users, if we just put the name directly it would create multiple users with same name. For this we can use the 'count.index' to create different users. here the users would be 'neo.0,neo.1,neo.2'
  #name = "neo.${count.index}"
  # as Terraform can't do for loops, we can use 'count' to create multiple users
  #count = 3
  #using a var file to create the users from a list
  name = var.user_names[count.index]
  count = length(var.user_names)
}