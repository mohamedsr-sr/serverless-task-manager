output "dynamodb_table_name" {
  description = "DynamoDB table name"
  value       = aws_dynamodb_table.tasks.name
}

output "create_task_lambda_name" {
  description = "Create task Lambda function name"
  value       = aws_lambda_function.create_task.function_name
}

output "get_tasks_lambda_name" {
  description = "Get tasks Lambda function name"
  value       = aws_lambda_function.get_tasks.function_name
}

output "api_url" {
  description = "API Gateway base URL"
  value       = aws_apigatewayv2_stage.default.invoke_url
}