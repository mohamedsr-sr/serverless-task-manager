# Serverless Task Manager

A serverless task management API built using AWS Lambda, Amazon API Gateway, Amazon DynamoDB, AWS IAM, Amazon CloudWatch, and Terraform.

The project demonstrates how to build and manage a serverless REST API using Infrastructure as Code (IaC), with AWS Lambda handling the application logic and DynamoDB providing persistent task storage.

## Table of Contents

- [Solution Overview](#solution-overview)
- [Architecture Diagram](#architecture-diagram)
- [AWS Services](#aws-services)
- [Project Structure](#project-structure)
- [API Endpoints](#api-endpoints)
- [Infrastructure as Code](#infrastructure-as-code)
- [Prerequisites](#prerequisites)
- [AWS Configuration](#aws-configuration)
- [Terraform Deployment](#terraform-deployment)
- [Testing](#testing)
- [Monitoring and Logging](#monitoring-and-logging)
- [Security](#security)
- [Infrastructure Cleanup](#infrastructure-cleanup)
- [Future Improvements](#future-improvements)
- [License](#license)

---

## Solution Overview

The Serverless Task Manager is a REST API designed to create and retrieve tasks using a fully serverless AWS architecture.

The solution uses Amazon API Gateway as the entry point for HTTP requests. API Gateway routes requests to AWS Lambda functions, which process the application logic and communicate with Amazon DynamoDB for data storage.

The infrastructure is defined and managed using Terraform.

### Main Request Flow

```text
Client
   |
   v
Amazon API Gateway
   |
   +--------------------+
   |                    |
   v                    v
POST /tasks          GET /tasks
   |                    |
   v                    v
Create Task Lambda   Get Tasks Lambda
   |                    |
   +---------+----------+
             |
             v
      Amazon DynamoDB
Architecture Diagram

The architecture consists of:

Client
Amazon API Gateway
AWS Lambda
Amazon DynamoDB
AWS IAM
Amazon CloudWatch
Terraform
AWS Services
AWS Service	Purpose
Amazon API Gateway	Provides the HTTP API and routes requests
AWS Lambda	Executes serverless application logic
Amazon DynamoDB	Stores task data
AWS IAM	Provides permissions and execution roles
Amazon CloudWatch	Collects Lambda logs
Terraform	Provisions and manages AWS infrastructure
Project Structure
serverless-task-manager/
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── provider.tf
│   └── iam.tf
│
├── lambda/
│   ├── create-task/
│   │   └── index.py
│   │
│   └── get-tasks/
│       └── index.py
│
├── architecture.png
├── .gitignore
└── README.md
API Endpoints
Create Task

Creates a new task and stores it in DynamoDB.

Endpoint:

POST /tasks

Request Body:

{
  "title": "Learn Terraform",
  "description": "Build a serverless application using AWS"
}
Get Tasks

Returns all tasks stored in DynamoDB.

Endpoint:

GET /tasks
Infrastructure as Code

Terraform is used to provision and manage the AWS infrastructure.

Terraform manages:

Amazon API Gateway
AWS Lambda
Amazon DynamoDB
IAM Roles
IAM Policies
Lambda Permissions
CloudWatch logging
Prerequisites

Before deploying the project, install:

AWS CLI
Terraform
Git
Python 3.12+

Verify the installations:

aws --version
terraform -version
git --version
python --version
AWS Configuration

Configure the AWS CLI:

aws configure

Configure your:

AWS Access Key ID
AWS Secret Access Key
Default region: us-east-1
Default output format: json

Verify your AWS identity:

aws sts get-caller-identity

Never commit AWS credentials, secrets, or Terraform state files to GitHub.

Terraform Deployment

Navigate to the Terraform directory:

cd terraform

Initialize Terraform:

terraform init

Format the Terraform files:

terraform fmt

Validate the configuration:

terraform validate

Preview the infrastructure changes:

terraform plan

Deploy the infrastructure:

terraform apply

Confirm the deployment when prompted:

yes
Terraform Outputs

After deployment:

terraform output api_url

Get the DynamoDB table name:

terraform output dynamodb_table_name

Get the Create Task Lambda name:

terraform output create_task_lambda_name

Get the Get Tasks Lambda name:

terraform output get_tasks_lambda_name
Testing
Get Tasks
curl https://YOUR_API_URL/tasks
Create Task
curl -X POST https://YOUR_API_URL/tasks \
  -H "Content-Type: application/json" \
  -d "{\"title\":\"Learn AWS\",\"description\":\"Build a serverless application\"}"

After creating a task, call:

curl https://YOUR_API_URL/tasks

The created task should be returned from DynamoDB.

Monitoring and Logging

AWS Lambda sends execution logs to Amazon CloudWatch Logs.

CloudWatch can be used to monitor:

Lambda invocations
Lambda errors
Execution duration
Application logs
API activity
Security

The project uses AWS IAM to control access between Lambda and DynamoDB.

Lambda functions use IAM execution roles with permissions required for:

DynamoDB operations
CloudWatch logging

Security best practices:

Never commit AWS credentials.
Never commit Terraform state files.
Do not hard-code secrets.
Use IAM roles instead of hard-coded credentials.
Follow the principle of least privilege.
Infrastructure Cleanup

When the infrastructure is no longer needed:

terraform destroy

Confirm when prompted:

yes

This removes the AWS resources managed by Terraform and helps avoid unnecessary AWS charges.

Future Improvements
Add PUT /tasks/{id}
Add DELETE /tasks/{id}
Add task status management
Add authentication using Amazon Cognito
Add automated unit tests
Add CI/CD using GitHub Actions
Add Terraform remote state
Add development and production environments
Add CloudWatch alarms
Add custom API domain
Add OpenAPI documentation
Technologies
AWS Lambda
Amazon API Gateway
Amazon DynamoDB
AWS IAM
Amazon CloudWatch
Terraform
Python
Git
GitHub
Author

Mohamed Yasser

DevOps / Cloud Engineer

License

This project is created for educational and portfolio purposes.
