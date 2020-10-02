resource "aws_api_gateway_rest_api" "smarthouse_rest_api" {
  name = "${var.environment}_smarthouse_rest_api"
  description = "Smarthouse REST API"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.smarthouse_rest_api.id}"
  parent_id = "${aws_api_gateway_rest_api.smarthouse_rest_api.root_resource_id}"
  path_part = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.smarthouse_rest_api.id}"
  resource_id = "${aws_api_gateway_resource.proxy.id}"
  http_method = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.smarthouse_rest_api.id}"
  resource_id = "${aws_api_gateway_method.proxy.resource_id}"
  http_method = "${aws_api_gateway_method.proxy.http_method}"

  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${var.events_handler_invoke_arn}"
}

resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id = "${aws_api_gateway_rest_api.smarthouse_rest_api.id}"
  resource_id = "${aws_api_gateway_rest_api.smarthouse_rest_api.root_resource_id}"
  http_method = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = "${aws_api_gateway_rest_api.smarthouse_rest_api.id}"
  resource_id = "${aws_api_gateway_method.proxy_root.resource_id}"
  http_method = "${aws_api_gateway_method.proxy_root.http_method}"

  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${var.events_handler_invoke_arn}"
}

resource "aws_api_gateway_deployment" "smarthouse_rest_api_deployment" {
  depends_on = [
    "aws_api_gateway_integration.lambda",
    "aws_api_gateway_integration.lambda_root",
  ]

  rest_api_id = "${aws_api_gateway_rest_api.smarthouse_rest_api.id}"
  stage_name = "${var.environment}_stage"
}

resource "aws_lambda_permission" "apigw_lambda_invoke_permission" {
  statement_id = "${var.environment}_AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${var.events_handler_function_name}"
  principal = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.smarthouse_rest_api.execution_arn}/*/*"
}