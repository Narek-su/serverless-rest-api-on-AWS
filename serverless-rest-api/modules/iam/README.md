# This module creates:

- IAM role that allows AWS Lambda to adopt it  
- IAM policy with permissions to:  
  - Read/write to the specified DynamoDB table  
  - Write logs to CloudWatch Logs for visibility  
- Attaches the policy to the created role  

---

## Recommended variables to customize:

| Variable                    | Description                                                                |
|-----------------------------|----------------------------------------------------------------------------|
| iam_role_name               | Name of the IAM Role for Lambda                                            |
| dynamodb_access_policy_name | Name for the IAM policy that grants DynamoDB and logging access            |
| table_arn                   | ARN of the DynamoDB table the Lambda should access                         |
| logs_arguments              | Object containing `region`, `account_id`, and `lambda_name` for log access |

---

## Outputs:

| Output                 | Description                          |
|------------------------|--------------------------------------|
| iam_lambda_role_arn    | ARN of the created IAM Role          |
| iam_lambda_role_name   | Name of the created IAM Role         |
