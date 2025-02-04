variable "names" {
    description = "A list of names"
    type = list(string)
    default = [ "neo","trinity","morpheus" ]
}


/* make the list uppercase */
output "upper_names" {
  value = [for name in var.names : upper(name)]
}

/* make the list uppercase for enties with specific lenght */
output "upper_case_specific_lenght" {
    value = [for name in var.names : upper(name) if length(name) <5]
}

/* loop over a map */
variable "hero_thousand_faces" {
  description = "map"
  type = map(string)
  default = {
    "neo" = "hero"
    "trinity" = "love interest"
    "morpheus" = "mentor"
  }
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}

/* output a map and not a list - notice that it's in CURLY brackets instead of square brackets */
output "upper_roles" {
  value = {for name, role in var.hero_thousand_faces :upper(name) => upper(role)}
}