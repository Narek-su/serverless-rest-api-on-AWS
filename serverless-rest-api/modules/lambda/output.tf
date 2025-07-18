output "lambda_arns" {
  value = {
    for name, lambda in aws_lambda_function.lambda_function :
    name => lambda.arn
  }
}
