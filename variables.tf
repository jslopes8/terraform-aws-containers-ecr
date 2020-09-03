variable "create" {
    type = bool 
    default = true
}
variable "name_repo" {
    type = string
}
variable "image_tag_mutability" {
    type = string 
    default = "MUTABLE"
}
variable "encryption_configuration" {
    type = any 
    default = []
}
variable "image_scanning_configuration" {
    type = any 
    default = []
}
variable "repository_policy" {
    type = any 
    default = []
}