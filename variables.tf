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
variable "lifecycle_policy" {
    type = any
    default = []
}
variable "default_tags" {
    type = map(string)
    default = {}
}
variable "docker_source_path" {
    type = string
    default = null
}
variable "docker_image_name" {
    type = string
    default = null
}
variable "docker_image_tag" {
    type = string
    default = null
}
variable "git_source_url" {
    type = string
    default = null
}