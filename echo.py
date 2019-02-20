#!/usr/bin/env python
import os
import boto3

def bucket_notification(event, context):
    print(event)
    print(context)
    table_name = os.environ['DB_TABLE']
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(table_name)
    table.put_item(
        Item={
            'object_name': event['Records'][0]['s3']['object']['key'],
            'deleted_at':  event['Records'][0]['eventTime']
        }
    )