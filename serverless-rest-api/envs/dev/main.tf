module "dynamodb" {
  source = "../../modules/dynamodb"

  dynamodb_table_name = var.dynamodb_table_name

  tags = local.common_tags
}

module "iam" {
  source = "../../modules/iam"

  iam_role_name               = var.iam_role_name
  dynamodb_access_policy_name = var.dynamodb_access_policy_name
  table_arn                   = module.dynamodb.table_arn

  logs_arguments = {
    region      = var.region
    account_id  = local.account_id
    lambda_name = var.function_name
  }
}

module "lambda" {
  source = "../../modules/lambda"

  functions = {
    lambda = {
      handler          = "handler.lambda_handler"
      runtime          = "python3.13"
      filename         = "handler.zip"
      source_code_hash = filebase64sha256("handler.zip")
      role             = module.iam.iam_lambda_role_arn
      environment      = {}
    }
  }

  dynamodb_table_name = module.dynamodb.table_name
  iam_lambda_role_arn = module.iam.iam_lambda_role_arn

  tags = local.common_tags
}

module "api_gateway" {
  source = "../../modules/api_gateway"

  lambda_arns = {
    function_name = var.function_name
    lambda        = module.lambda.lambda_arns["lambda"]
  }

  resource_path = var.resource_path

  allow_apigw_permission = {
    region     = var.region
    account_id = local.account_id
  }

  region = var.region

  methods = {
    POST = {
      integration_http_method = "POST"
    }
    GET = {
      integration_http_method = "POST"
    }
  }
}
