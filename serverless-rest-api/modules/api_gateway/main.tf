resource "aws_api_gateway_rest_api" "api" {
  name = "lambda-api"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = var.resource_path
}

resource "aws_api_gateway_method" "method" {
  for_each = var.methods

  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = each.key
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  for_each = var.methods

  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = each.key

  integration_http_method = each.value.integration_http_method
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_arns.lambda}/invocations"
}

resource "aws_api_gateway_method_response" "response_200" {
  for_each    = var.methods
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = each.key

  status_code = "200"
  depends_on  = [aws_api_gateway_method.method]
}

resource "aws_api_gateway_integration_response" "post_integration_response" {
  for_each    = var.methods
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = each.key

  status_code = aws_api_gateway_method_response.response_200[each.key].status_code

  depends_on = [
    aws_api_gateway_method_response.response_200,
    aws_api_gateway_integration.integration
  ]
}

resource "aws_lambda_permission" "allow_apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arns.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.allow_apigw_permission.region}:${var.allow_apigw_permission.account_id}:${aws_api_gateway_rest_api.api.id}/*/*/${aws_api_gateway_resource.resource.path_part}"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on  = [aws_api_gateway_integration.integration]
  rest_api_id = aws_api_gateway_rest_api.api.id
}

