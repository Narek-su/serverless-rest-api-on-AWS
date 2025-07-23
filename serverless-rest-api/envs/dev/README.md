# Serverless REST API on AWS (Terraform)

This Terraform root module deploys a serverless REST API on AWS using Lambda, API Gateway, and DynamoDB.

---

## What this module creates:

- DynamoDB table for data storage (on-demand billing)  
- IAM Role with least-privilege policy for Lambda to access DynamoDB and CloudWatch logs  
- Lambda function for handling API requests (GET and POST)  
- API Gateway REST API that invokes the Lambda function  

---

## Recommended variables to customize:

| Variable                      | Description                                                                 |
|-------------------------------|-----------------------------------------------------------------------------|
| dynamodb_table_name           | Name of the DynamoDB table                                                  |
| iam_role_name                 | IAM Role name for Lambda                                                    |
| dynamodb_access_policy_name   | Name of the IAM policy that grants DynamoDB access                          |
| function_name                 | Name of the Lambda function                                                 |
| region                        | AWS region to deploy to (e.g., eu-north-1)                                  |
| local.account_id              | Automatically retrieved AWS Account ID via data.aws_caller_identity         |
| methods                       | Map of HTTP methods and their integration config with Lambda                |
| resource_path                 | API Gateway resource path (e.g., items)                                     |
| tags / local.common_tags      | Map of tags applied to all resources (e.g., env, by)                        |

---

## Outputs:

| Output          | Description                                      |
|-----------------|--------------------------------------------------|
| table_name      | Name of the created DynamoDB table               |
| lambda_arns     | Map of Lambda function ARNs                      |
| api_invoke_url  | API Gateway invoke URL                           |

---

## Lambda Function Code Packaging:

The Lambda function must be packaged into a `.zip` file before deploying with Terraform.  
Make sure your file (e.g., `handler.py`) is zipped and named as specified in filename.

**Example:**

```bash
zip handler.zip handler.py
```

---

## Example Lambda Function Behavior

The Lambda handles:

- `GET /items?id=123`: Reads an item from DynamoDB by ID  
- `POST /items`: Creates an item in DynamoDB using JSON body  

**Example request:**

```bash
curl -X POST https://<invoke_url>/items \
  -H "Content-Type: application/json" \
  -d '{"id": "123", "data": "hello"}'
```

---

## Make sure to configure your AWS credentials before running Terraform

(e.g., `aws configure` or environment variables)

---

## Requirements

- Terraform v1.12.2  
- AWS CLI installed and configured (`aws configure`)  
- S3 bucket for storing remote state (see `terraform.backend` section in `main.tf`)  

---

## How to use

```bash
git clone https://github.com/Narek-su/Serverless-REST-API-on-AWS.git

cd serverless-rest-api/envs/dev

# Initialize Terraform
terraform init

# Review changes
terraform plan

# Apply the configuration
terraform apply
```
