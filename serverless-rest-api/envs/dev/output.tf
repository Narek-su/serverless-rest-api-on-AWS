output "table_name" {
  value = module.dynamodb.table_name
}

output "lambda_arns" {
  value = module.lambda.lambda_arns
}

output "api_invoke_url" {
  value = module.api_gateway.api_invoke_url
}