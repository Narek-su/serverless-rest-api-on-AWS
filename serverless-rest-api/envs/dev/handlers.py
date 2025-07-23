import json
import boto3
import os

dynamodb = boto3.resource('dynamodb')
table_name = os.environ['DYNAMODB_TABLE']
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    http_method = event.get('httpMethod')
    if http_method == 'GET':
        # Read item from DynamoDB by 'id' passed as query param
        item_id = event.get('queryStringParameters', {}).get('id')
        if not item_id:
            return response(400, {'error': 'Missing id parameter'})

        try:
            result = table.get_item(Key={'id': item_id})
            item = result.get('Item')
            if not item:
                return response(404, {'error': 'Item not found'})
            return response(200, item)
        except Exception as e:
            return response(500, {'error': str(e)})

    elif http_method == 'POST':
        # Create item in DynamoDB from JSON body
        try:
            body = json.loads(event.get('body') or '{}')
            item_id = body.get('id')
            data = body.get('data')
            if not item_id or not data:
                return response(400, {'error': 'Missing id or data in body'})

            table.put_item(Item={'id': item_id, 'data': data})
            return response(201, {'message': 'Item created', 'id': item_id})
        except Exception as e:
            return response(500, {'error': str(e)})

    else:
        return response(405, {'error': f'Method {http_method} not allowed'})

def response(status_code, body):
    return {
        'statusCode': status_code,
        'headers': {'Content-Type': 'application/json'},
        'body': json.dumps(body)
    }
