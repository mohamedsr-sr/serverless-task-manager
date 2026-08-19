# =========================
# DynamoDB
# =========================

resource "aws_dynamodb_table" "tasks" {
  name         = "${var.project_name}-tasks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Project = var.project_name
  }
}


# =========================
# Create Task Lambda
# =========================

data "archive_file" "create_task" {
  type        = "zip"
  source_dir  = "${path.module}/../lambda/create-task"
  output_path = "${path.module}/create-task.zip"
}

resource "aws_lambda_function" "create_task" {
  function_name = "${var.project_name}-create-task"

  filename         = data.archive_file.create_task.output_path
  source_code_hash = data.archive_file.create_task.output_base64sha256

  runtime = "python3.12"
  handler = "index.lambda_handler"

  role = aws_iam_role.lambda_role.arn

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.tasks.name
    }
  }
}


# =========================
# Get Tasks Lambda
# =========================

data "archive_file" "get_tasks" {
  type        = "zip"
  source_dir  = "${path.module}/../lambda/get-tasks"
  output_path = "${path.module}/get-tasks.zip"
}

resource "aws_lambda_function" "get_tasks" {
  function_name = "${var.project_name}-get-tasks"

  filename         = data.archive_file.get_tasks.output_path
  source_code_hash = data.archive_file.get_tasks.output_base64sha256

  runtime = "python3.12"
  handler = "index.lambda_handler"

  role = aws_iam_role.lambda_role.arn

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.tasks.name
    }
  }
}


# =========================
# API Gateway
# =========================

resource "aws_apigatewayv2_api" "tasks_api" {
  name          = "${var.project_name}-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST", "OPTIONS"]
    allow_headers = ["content-type"]
  }
}


# =========================
# API Gateway -> Create Lambda
# =========================

resource "aws_apigatewayv2_integration" "create_task" {
  api_id = aws_apigatewayv2_api.tasks_api.id

  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.create_task.invoke_arn
  integration_method = "POST"

  payload_format_version = "2.0"
}


# =========================
# API Gateway -> Get Lambda
# =========================

resource "aws_apigatewayv2_integration" "get_tasks" {
  api_id = aws_apigatewayv2_api.tasks_api.id

  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.get_tasks.invoke_arn
  integration_method = "POST"

  payload_format_version = "2.0"
}


# =========================
# POST /tasks
# =========================

resource "aws_apigatewayv2_route" "create_task" {
  api_id = aws_apigatewayv2_api.tasks_api.id

  route_key = "POST /tasks"

  target = "integrations/${aws_apigatewayv2_integration.create_task.id}"
}


# =========================
# GET /tasks
# =========================

resource "aws_apigatewayv2_route" "get_tasks" {
  api_id = aws_apigatewayv2_api.tasks_api.id

  route_key = "GET /tasks"

  target = "integrations/${aws_apigatewayv2_integration.get_tasks.id}"
}


# =========================
# Default Stage
# =========================

resource "aws_apigatewayv2_stage" "default" {
  api_id = aws_apigatewayv2_api.tasks_api.id

  name = "$default"

  auto_deploy = true
}


# =========================
# API Gateway Permission - Create Task
# =========================

resource "aws_lambda_permission" "create_task_api" {
  statement_id  = "AllowAPIGatewayInvokeCreateTask"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.create_task.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.tasks_api.execution_arn}/*/*"
}


# =========================
# API Gateway Permission - Get Tasks
# =========================

resource "aws_lambda_permission" "get_tasks_api" {
  statement_id  = "AllowAPIGatewayInvokeGetTasks"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_tasks.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.tasks_api.execution_arn}/*/*"
}