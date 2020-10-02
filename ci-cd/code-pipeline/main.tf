resource "aws_iam_role" "code_pipeline_role" {
  name = "${var.environment}-code_pipeline_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "code_pipeline_policy" {
  role = "${aws_iam_role.code_pipeline_role.name}"

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

resource "aws_codepipeline" "codepipeline" {
  name     = "${var.environment}-smarthouse-pipeline"
  role_arn = "${aws_iam_role.code_pipeline_role.arn}"

  artifact_store {
    location = "${var.bucket_name}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner  = "${var.git_owner}"
        Repo   = "${var.git_service_repository}"
        Branch = "${var.service_branch}"
        OAuthToken = "${var.git_token}"
      }
    }

    action {
      name             = "TerraformSource"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["tf_source_output"]

      configuration = {
        Owner  = "${var.git_owner}"
        Repo   = "${var.git_infrastructure_repository}"
        Branch = "${var.infrastructure_branch}"
        OAuthToken = "${var.git_token}"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "${var.code_build_name}"
      }
    }
  }

  stage {
    name = "TerraformBuild"

    action {
      name             = "TerraformBuild"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["tf_source_output"]
      output_artifacts = ["tf_build_output"]
      version          = "1"

      configuration = {
        ProjectName = "${var.terraform_code_build_name}"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      version         = "1"
      input_artifacts  = ["build_output"]

      configuration = {
        ApplicationName = "${var.code_deploy_application_name}"
        DeploymentGroupName = "${var.deployment_group_name}"
      }
    }
  }
}
