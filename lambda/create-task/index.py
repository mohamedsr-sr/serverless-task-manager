import json
import os
import uuid
import boto3
from datetime import datetime, timezone

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])


def lambda_handler(event, context):
    try:
        body = json.loads(event.get("body") or "{}")

        title = body.get("title")
        description = body.get("description", "")

        if not title:
            return {
                "statusCode": 400,
                "headers": {
                    "Content-Type": "application/json"
                },
                "body": json.dumps({
                    "message": "title is required"
                })
            }

        task = {
            "id": str(uuid.uuid4()),
            "title": title,
            "description": description,
            "createdAt": datetime.now(timezone.utc).isoformat()
        }

        table.put_item(Item=task)

        return {
            "statusCode": 201,
            "headers": {
                "Content-Type": "application/json"
            },
            "body": json.dumps({
                "message": "Task created successfully",
                "task": task
            })
        }

    except Exception as error:
        return {
            "statusCode": 500,
            "headers": {
                "Content-Type": "application/json"
            },
            "body": json.dumps({
                "message": "Internal server error",
                "error": str(error)
            })
        }
    