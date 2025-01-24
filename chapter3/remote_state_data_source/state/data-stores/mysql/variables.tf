variable "db_username" {
  description = "The username for the database"
  type = string
  #marking as sensitive so terraform don't store the value on the state file
  sensitive = true
}

variable "db_password" {
  description = "The password for the database"
  type = string
  #marking as sensitive so terraform don't store the value on the state file
  sensitive = true
}