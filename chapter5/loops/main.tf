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
  #name = var.user_names[count.index]
  #count = length(var.user_names)
  #count has two limitations 1: can't be used in inline data blocks and 2: as it's positional, when we delete a count[1] item item while having a count[2] what it will actually do is change the postion of 2 to 1 while replacing it to the other part. 
# to solve that we use for_each loops
  for_each = toset(var.user_names) # for_each only supports sets and maps when used on a resource
  name =  each.value
}


# as now the users are an array of resources, we need to specify which user we want by its position in the array:
/*output "first_arn" {
  value = aws_iam_user.example[0].arn
  description = "The arn of the first user"
}
*/
# we can retrieve the arn of all users by using the "*" splat sign when using count

/*output "all_arns" {
  value = aws_iam_user.example[*].arn
  description = "The arn of each user"
}
*/

# if using for_each, we don't need to use * to get all users arns
output "all_users" {
  value = values(aws_iam_user.example)[*].arn
}


