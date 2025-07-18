variable "dynamodb_table_name" {
  type = string
}

variable "iam_lambda_role_arn" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "functions" {
  type = map(object({
    handler          = string
    runtime          = string
    filename         = string
    source_code_hash = string
    role             = string
    environment      = map(string)
  }))
}