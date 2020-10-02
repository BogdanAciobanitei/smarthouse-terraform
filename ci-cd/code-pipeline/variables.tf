variable "environment" {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "pipeline_name" {
  type = string
}
variable "code_build_name" {
}
variable "code_deploy_application_name" {
}
variable "deployment_group_name" {
}
variable "terraform_code_build_name" {
}
variable "git_owner" {
}
variable "git_service_repository" {
}
variable "git_infrastructure_repository" {
}
variable "service_branch" {
  type = "string"
}
variable "infrastructure_branch" {
  type = "string"
}
variable "git_token" {
  type = "string"
}
