data "archive_file" "events_handler" {
  type = "zip"
  source_dir = "${path.module}/events_handler"
  output_path = "${path.module}/events_handler.zip"
}

resource "aws_lambda_function" "events_handler" {
  filename = "${data.archive_file.events_handler.output_path}"
  function_name = "${var.environment}_events_handler"
  role = "${var.iam_role_for_lambda}"
  handler = "events_handler.handler"
  source_code_hash = "${filebase64sha256("${data.archive_file.events_handler.output_path}")}"
  layers = [
  ]
  runtime = "nodejs12.x"

  environment {
    variables = {
      queue_name = "https://sqs.eu-west-1.amazonaws.com/435382681489/${var.environment}-EventsQueue"
    }
  }
}
