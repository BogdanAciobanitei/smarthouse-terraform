output "events_handler_lambda_arn" {
  value = "${aws_lambda_function.events_handler.arn}"
}

output "events_handler_invoke_arn" {
  value = "${aws_lambda_function.events_handler.invoke_arn}"
}

output "events_lambda_function_name" {
  value = "${aws_lambda_function.events_handler.function_name}"
}