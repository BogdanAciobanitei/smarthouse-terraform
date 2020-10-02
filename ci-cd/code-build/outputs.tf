output "build_name" {
  value = aws_codebuild_project.code_build.name
}
output "terraform_build_name" {
  value = aws_codebuild_project.code_build_tf.name
}
