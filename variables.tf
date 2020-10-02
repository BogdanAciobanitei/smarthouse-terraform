#General variables
variable "environment" {
  type = string
  default = "smarthouse"
}
variable "bucket_name" {
  type = string
  default = "build-output"
}
variable "service_build_name" {
  type = string
  default = "smarthouse-build-service"
}
variable "pipeline_name" {
  type = string
  default = "smarthouse-pipeline"
}
variable "git_owner" {
  default = "BogdanAciobanitei"
}
variable "git_service_repository" {
  default = "smarthouse"
}
variable "git_infrastructure_repository" {
  default = "smarthouse-terraform"
}
variable "service_branch" {
  default = "master"
}
variable "infrastructure_branch" {
  default = "master"
}
variable "git_token" {
  default = "c2f67f36e794104b1dc5d7c458d2abc5c8de82ef"
}
variable "vpc_id" {
  default = "vpc-cf1f31a9"
}
