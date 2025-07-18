resource "aws_lambda_function" "lambda_function" {
  for_each = var.functions

  function_name    = each.key
  role             = each.value.role
  handler          = each.value.handler
  runtime          = each.value.runtime
  filename         = each.value.filename
  source_code_hash = each.value.source_code_hash

  environment {
    variables = merge(
      {
        DYNAMODB_TABLE = var.dynamodb_table_name
      },
      each.value.environment
    )
  }
  tags = var.tags
}