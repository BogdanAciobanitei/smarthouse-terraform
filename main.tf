terraform {
  backend "s3" {
    bucket = "smarthouse-state"
    key = "smarthouse-state.tfstate"
    region = "eu-west-1"
  }
}
provider "aws" {
  region = "eu-west-1"
  version = "~> 2.29"
}

module "messaging" {
  source = "./messaging"
  environment = "${var.environment}"
  elastic_mq_security_group_id = "${module.networking.elastic_mq_security_group_id}"
}

module "dynamo_db_tables" {
  source = "./data-stores/dynamo-db"
  environment = "${var.environment}"
}

module "s3_bucket" {
  source = "./file-stores/s3"
  environment = "${var.environment}"
  bucket_name = "${var.bucket_name}"
}

module "networking" {
  source = "./networking/security-groups"
  environment = "${var.environment}"
  vpc_id = "${var.vpc_id}"
}

module "ec2_instance" {
  source = "./virtual-machine/ec2"
  environment = "${var.environment}"
  security_groups = [
    "${module.networking.ec2_inbound_ssh_sg}",
    "${module.networking.ec2_outboud_sg}",
    "${module.networking.ec2_inbound_http_sg}"]
}

module "code_build" {
  source = "./ci-cd/code-build"
  environment = "${var.environment}"
  bucket_name = "${var.environment}-${var.bucket_name}"
  service_build_name = "${var.service_build_name}"
  git_infrastructure_repository = "${var.git_infrastructure_repository}"
  git_service_repository = "${var.git_service_repository}"
  git_owner = "${var.git_owner}"
}

module "code_deploy" {
  source = "./ci-cd/code-deploy"
  environment = "${var.environment}"
}

module "code_pipeline" {
  source = "./ci-cd/code-pipeline"
  bucket_name = "${var.environment}-${var.bucket_name}"
  pipeline_name = "${var.environment}-${var.pipeline_name}"
  environment = "${var.environment}"
  code_build_name = module.code_build.build_name
  terraform_code_build_name = module.code_build.terraform_build_name
  code_deploy_application_name = module.code_deploy.deploy_name
  deployment_group_name = module.code_deploy.deploiment_group_name
  git_infrastructure_repository = "${var.git_infrastructure_repository}"
  git_service_repository = "${var.git_service_repository}"
  git_owner = "${var.git_owner}"
  infrastructure_branch = "${var.infrastructure_branch}"
  service_branch = "${var.service_branch}"
  git_token = "${var.git_token}"
}

module "iam" {
  source = "./iam"
  environment = "${var.environment}"
  events_queue_arn = "${module.messaging.event_queue_arn}"
}

module "lambda" {
  source = "./lambda"
  environment = "${var.environment}"
  iam_role_for_lambda = "${module.iam.redis_lambda_role_arn}"
}

module "api_gw" {
  source = "./api-gw"
  environment = "${var.environment}"
  events_handler_function_name = "${module.lambda.events_lambda_function_name}"
  events_handler_invoke_arn = "${module.lambda.events_handler_invoke_arn}"
}
