resource "aws_iam_role" "iam_for_lambda" {
  name = "${var.environment}_iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "lambda_permission_for_queue" {
  statement {
    actions = [
      "sqs:*"]
    resources = [
//      "${var.events_queue_arn}"
    "*"
    ]
  }
}

data "aws_iam_policy_document" "lambda_permission_for_cloudwatch" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"]
    effect = "Allow"
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
}

resource "aws_iam_policy" "lambda_permission_policy" {
  policy = "${data.aws_iam_policy_document.lambda_permission_for_queue.json}"
}

resource "aws_iam_policy" "cloudwatch_permission_policy" {
  policy = "${data.aws_iam_policy_document.lambda_permission_for_cloudwatch.json}"
}

resource "aws_iam_role_policy_attachment" "lambda_role_sqs_policy_attachment" {
  role = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = "${aws_iam_policy.lambda_permission_policy.id}"
}

resource "aws_iam_role_policy_attachment" "lambda_role_cloudwatch_policy_attachment" {
  role = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = "${aws_iam_policy.cloudwatch_permission_policy.id}"
}
