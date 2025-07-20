# This module creates:

- One or multiple AWS Lambda functions using `for_each`  
- Each function can have custom handler, runtime, environment, and role  
- Environment variables include a shared `DYNAMODB_TABLE` name and optional custom variables  
- Custom tags to apply to all resources  

---

## Recommended variables to customize:

| Variable               | Description                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| functions              | Map of Lambda function definitions. Each entry contains:<br>• `handler` – Lambda handler<br>• `runtime` – (e.g., python3.12)<br>• `filename` – Path to ZIP file<br>• `source_code_hash` – hash of the ZIP<br>• `role` – IAM role ARN<br>• `environment` – Optional map of environment variables |
| iam_lambda_role_arn    | IAM Role ARN for Lambda functions                                           |
| dynamodb_table_name    | Name of the DynamoDB table injected into all functions via `DYNAMODB_TABLE` |
| tags                   | Map of tags applied to all Lambda functions                                 |

---

## Outputs:

| Output       | Description                                   |
|--------------|-----------------------------------------------|
| lambda_arns  | Map of function names to their ARNs           |
