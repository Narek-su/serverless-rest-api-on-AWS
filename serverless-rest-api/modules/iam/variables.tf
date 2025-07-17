variable "iam_role_name" {
  type = string
}

variable "dynamodb_access_policy_name" {
  type = string
}

variable "table_arn" {
  type = string
}

variable "logs_arguments" {
  type = object({
    region      = string
    account_id  = string
    lambda_name = string
  })
}
