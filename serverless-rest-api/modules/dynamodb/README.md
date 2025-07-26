# This module creates:

- DynamoDB table with on-demand (PAY_PER_REQUEST) billing mode  
- Uses a simple schema with a single partition key (`id`, type `String`)  
- Applies custom tags for resource organization and cost tracking  

---

## Recommended variables to customize:

| Variable             | Description                               |
|----------------------|-------------------------------------------|
| dynamodb_table_name  | Name of the DynamoDB table                |
| tags                 | Map of tags to apply to the table         |

---

## Outputs:

| Output      | Description                               |
|-------------|-------------------------------------------|
| table_name  | Name of the created DynamoDB table        |
| table_arn   | ARN of the created DynamoDB table         |
