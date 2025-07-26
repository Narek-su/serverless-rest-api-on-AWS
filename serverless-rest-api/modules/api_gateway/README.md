# This module creates:

- REST API using AWS API Gateway  
- Custom resource path (e.g., /items)  
- Multiple HTTP methods (e.g., GET, POST) integrated with a Lambda function via AWS_PROXY  
- Lambda permission to allow API Gateway to invoke it  
- Deployment and default stage (dev)  

---

## Recommended variables to customize:

| Variable               | Description                                                                |
|------------------------|----------------------------------------------------------------------------|
| resource_path          | Resource path to create (e.g., items)                                      |
| methods                | Map of HTTP methods and integration types                                  |
| lambda_arns            | Object containing:<br>• `lambda` – Full Lambda ARN for integration<br>• `function_name` – For Lambda permission |
| region                 | AWS region                                                                 |
| allow_apigw_permission | Object containing:<br>• `region`<br>• `account_id` – Used to define `source_arn` for Lambda permission |

---

## Outputs:

| Output           | Description                               |
|------------------|-------------------------------------------|
| api_invoke_url   | Full invoke URL for the REST API          |
