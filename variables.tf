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
  default = "53dae8a3110742268f89d1515f626de944af5b39"
}
variable "vpc_id" {
  default = "vpc-fe77ba87"
}
