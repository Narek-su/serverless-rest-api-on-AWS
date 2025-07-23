#--------------------------------------------------dynamodb---------------------------------------------------------#
variable "dynamodb_table_name" {
  type    = string
  default = "rest_api_dev"
}

variable "iam_role_name" {
  type    = string
  default = "lambda_access_role"
}

variable "dynamodb_access_policy_name" {
  type    = string
  default = "dynamodb_access_policy"
}

variable "function_name" {
  type    = string
  default = "lambda"
}

#--------------------------------------------CloudWatch logs arguments----------------------------------------------#
variable "region" {
  type    = string
  default = "eu-north-1"
}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

#-----------------------------------------------------methods-------------------------------------------------------#
variable "methods" {
  type = map(object({
    integration_http_method = string
  }))

  default = {
    POST = {
      integration_http_method = "POST"
    }
    GET = {
      integration_http_method = "POST"
    }
  }
}

variable "resource_path" {
  type    = string
  default = "items"
}

#-----------------------------------------------------common tags----------------------------------------------------#
locals {
  common_tags = {
    env = "dev"
    by  = "terraform"
  }
}