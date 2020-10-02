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
  default = "b30861492eef65474f560ff57edcf92389181806"
}
variable "vpc_id" {
  default = "vpc-cf1f31a9"
}
