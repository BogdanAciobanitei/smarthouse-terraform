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
  default = "603a96beac8b535444e4efff40576ec82b8e22cb"
}
variable "vpc_id" {
  default = "vpc-fe77ba87"
}
