variable "methods" {
  type = map(object({
    integration_http_method = string
  }))
}

variable "resource_path" {
  type = string
}

variable "region" {
  type = string
}

variable "lambda_arns" {
  type = object({
    function_name = string
    lambda        = string
  })
}

variable "allow_apigw_permission" {
  type = object({
    region     = string
    account_id = string
  })
}