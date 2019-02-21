import boto3
import os
from moto import mock_dynamodb2
from echo import bucket_notification

event = {'Records': [{'eventVersion': '2.1', 'eventSource': 'aws:s3', 'awsRegion': 'us-east-1', 'eventTime': '2019-02-20T06:09:43.200Z', 'eventName': 'ObjectRemoved:Delete', 'userIdentity': {'principalId': 'AWS:AIDAJ7SHBHH64AOH3ABLU'}, 'requestParameters': {'sourceIPAddress': '220.232.211.45'}, 'responseElements': {'x-amz-request-id': 'D5680288E98096D0', 'x-amz-id-2': '3wS0NwxAHZvvwkJWqrfhcv8clfqdMfc0HhzocsrAWmTiOSNt6/wTIE7g9NQB7ZwJR0gQFLvYBy4='}, 's3': {'s3SchemaVersion': '1.0', 'configurationId': 'tf-s3-lambda-20190220060717136700000002', 'bucket': {'name': 'ubisoft163', 'ownerIdentity': {'principalId': 'AEW2IL19MNA07'}, 'arn': 'arn:aws:s3:::ubisoft163'}, 'object': {'key': '1.png', 'sequencer': '005C6CEF2731196E57'}}}]}
contex = '<bootstrap.LambdaContext object at 0x7f970adbbd68>'
os.environ['DB_TABLE']='BucketOperations'

@mock_dynamodb2
def test_lambdafunction():
    print("start")
    table_name = 'BucketOperations'
    dynamodb = boto3.resource('dynamodb', 'us-east-1')
    table = dynamodb.create_table(
        TableName=table_name,
        KeySchema=[
            {
                'AttributeName': 'object_name',
                'KeyType': 'HASH'
            },
            {
                'AttributeName': 'deleted_at',
                'KeyType': 'RANGE'
            },
        ],
        AttributeDefinitions=[
            {
                'AttributeName': 'deleted_at',
                'AttributeType': 'S'
            },
            {
                'AttributeName': 'object_name',
                'AttributeType': 'S'
            },
        ],
        ProvisionedThroughput={
            'ReadCapacityUnits': 1,
            'WriteCapacityUnits': 1
        }
    )
    table.meta.client.get_waiter('table_exists').wait(TableName=table_name)
    print('Test lambda function here')
    bucket_notification(event, contex)
    table = dynamodb.Table(table_name)
    response = table.get_item(
         Key={
              'object_name': '1.png',
              'deleted_at': '2019-02-20T06:09:43.200Z'
          }
         )
    if 'Item' in response:
         item = response['Item']
