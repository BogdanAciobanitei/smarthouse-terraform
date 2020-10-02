resource "aws_iam_role" "code_deploy_role" {
  name = "${var.environment}-code_deploy_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = "${aws_iam_role.code_deploy_role.name}"
}

resource "aws_codedeploy_app" "code_deploy_service" {
  name             = "${var.environment}-smarthouse-deploy"
}

resource "aws_codedeploy_deployment_group" "code_deploy_group" {
  app_name              = "${aws_codedeploy_app.code_deploy_service.name}"
  deployment_group_name = "${var.environment}-smarthouse-deployment-group"
  service_role_arn      = "${aws_iam_role.code_deploy_role.arn}"

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "${var.environment}-ec2_instance"
    }
  }


}
