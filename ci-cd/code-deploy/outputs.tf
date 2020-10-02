output "deploy_name" {
  value = aws_codedeploy_app.code_deploy_service.name
}
output "deploiment_group_name" {
  value = aws_codedeploy_deployment_group.code_deploy_group.deployment_group_name
}
