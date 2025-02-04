variable "names" {
    description = "Names to render"
    type = list(string)
    default = [ "neo", "trinity" , "morpheus" ]
}

/* output for_directive as a string */
output "for_directive" {
    value = "%{for name in var.names}${name}, %{endfor}"
}

/* output for_directive as a string index */
output "for_directive_index" {
    value = "%{for i, name in var.names}(${i})${name}, %{endfor}"
}