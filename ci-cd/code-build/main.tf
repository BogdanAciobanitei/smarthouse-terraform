resource "aws_iam_role" "code_build_role" {
  name = "${var.environment}-code_build_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "code_build_policy" {
  role = "${aws_iam_role.code_build_role.name}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "*"
      ]
    }
  ]
}
POLICY
}

resource "aws_codebuild_project" "code_build" {
  name          = "${var.environment}-${var.service_build_name}"
  service_role  = "${aws_iam_role.code_build_role.arn}"

  source {
    type            = "GITHUB"
    location        = "https://github.com/${var.git_owner}/${var.git_service_repository}.git"
    git_clone_depth = 1
  }

  artifacts {
    type = "S3"
    location = "${var.bucket_name}"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:2.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

}

resource "aws_codebuild_project" "code_build_tf" {
  name          = "${var.environment}-${var.service_build_name}-tf"
  service_role  = "${aws_iam_role.code_build_role.arn}"

  source {
    type            = "GITHUB"
    location        = "https://github.com/${var.git_owner}/${var.git_infrastructure_repository}.git"
    git_clone_depth = 1
  }

  artifacts {
    type = "S3"
    location = "${var.bucket_name}"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:2.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

}
