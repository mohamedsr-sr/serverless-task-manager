# Serverless Task Manager

A serverless task management REST API built using **AWS Lambda, Amazon API Gateway, Amazon DynamoDB, AWS IAM, Amazon CloudWatch, and Terraform**.

This project demonstrates how to build and manage a serverless application using **Infrastructure as Code (IaC)**, with AWS Lambda handling the application logic and DynamoDB providing persistent task storage.

---

## 📋 Table of Contents

* [Solution Overview](#solution-overview)
* [Architecture](#architecture)
* [AWS Services](#aws-services)
* [Project Structure](#project-structure)
* [API Endpoints](#api-endpoints)
* [Infrastructure as Code](#infrastructure-as-code)
* [Prerequisites](#prerequisites)
* [AWS Configuration](#aws-configuration)
* [Terraform Deployment](#terraform-deployment)
* [Terraform Outputs](#terraform-outputs)
* [Testing](#testing)
* [Monitoring and Logging](#monitoring-and-logging)
* [Security](#security)
* [Infrastructure Cleanup](#infrastructure-cleanup)
* [Future Improvements](#future-improvements)
* [Technologies](#technologies)
* [Author](#author)
* [License](#license)

---

## 🚀 Solution Overview

The **Serverless Task Manager** is a REST API designed to create and retrieve tasks using a fully serverless AWS architecture.

The application uses **Amazon API Gateway** as the entry point for HTTP requests. API Gateway routes requests to **AWS Lambda** functions, which process the application logic and communicate with **Amazon DynamoDB** for persistent data storage.

The entire infrastructure is provisioned and managed using **Terraform**.

### Request Flow

```text
                         ┌──────────────────┐
                         │      Client      │
                         └────────┬─────────┘
                                  │
                                  ▼
                       ┌─────────────────────┐
                       │   Amazon API        │
                       │      Gateway        │
                       └─────────┬───────────┘
                                 │
                    ┌────────────┴────────────┐
                    │                         │
                    ▼                         ▼
              POST /tasks                GET /tasks
                    │                         │
                    ▼                         ▼
          ┌─────────────────┐       ┌─────────────────┐
          │  Create Task    │       │   Get Tasks     │
          │     Lambda      │       │     Lambda      │
          └────────┬────────┘       └────────┬────────┘
                   │                         │
                   └────────────┬────────────┘
                                │
                                ▼
                      ┌─────────────────────┐
                      │   Amazon DynamoDB   │
                      │    Tasks Table      │
                      └─────────────────────┘

          AWS IAM → Permissions & Access Control
          CloudWatch → Logging & Monitoring
          Terraform → Infrastructure as Code
```

---

## 🏗️ Architecture

The solution consists of the following components:

* **Client** – Sends HTTP requests to the API.
* **Amazon API Gateway** – Provides the REST API and routes requests.
* **AWS Lambda** – Executes the application logic.
* **Amazon DynamoDB** – Stores task data.
* **AWS IAM** – Controls permissions and access between AWS services.
* **Amazon CloudWatch** – Collects Lambda execution logs.
* **Terraform** – Provisions and manages the infrastructure.
  

### Architecture Diagram:


The project architecture diagram is available in:
<img width="1051" height="750" alt="Screenshot 2026-08-19 122230" src="https://github.com/user-attachments/assets/511b54b6-ebc5-4275-a8a6-715c06515e7a" />


```text

```

---

## ☁️ AWS Services

| Service                | Purpose                                             |
| ---------------------- | --------------------------------------------------- |
| **Amazon API Gateway** | Provides the HTTP API and routes requests to Lambda |
| **AWS Lambda**         | Executes serverless application logic               |
| **Amazon DynamoDB**    | Provides persistent task storage                    |
| **AWS IAM**            | Manages permissions and Lambda execution roles      |
| **Amazon CloudWatch**  | Collects and monitors Lambda logs                   |
| **Terraform**          | Provisions and manages AWS infrastructure           |

---

## 📁 Project Structure

```text
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
```

---

## 🔌 API Endpoints

### 1. Create Task

Creates a new task and stores it in DynamoDB.

**Method:**

```text
POST /tasks
```

**Request Body:**

```json
{
  "title": "Learn Terraform",
  "description": "Build a serverless application using AWS"
}
```

---

### 2. Get Tasks

Returns all tasks stored in DynamoDB.

**Method:**

```text
GET /tasks
```

---

## 🛠️ Infrastructure as Code

Terraform is used to provision and manage the complete AWS infrastructure.

Terraform manages:

* Amazon API Gateway
* AWS Lambda functions
* Amazon DynamoDB
* IAM execution roles
* IAM policies
* Lambda permissions
* CloudWatch logging resources

Using Terraform provides:

* **Infrastructure as Code**
* **Repeatable deployments**
* **Version-controlled infrastructure**
* **Easy infrastructure cleanup**
* **Consistent environments**

---

## 📦 Prerequisites

Before deploying the project, make sure the following tools are installed:

* AWS CLI
* Terraform
* Git
* Python 3.12+

Verify the installations:

```bash
aws --version
terraform -version
git --version
python --version
```

---

## 🔐 AWS Configuration

Configure the AWS CLI:

```bash
aws configure
```

Provide the required information:

```text
AWS Access Key ID
AWS Secret Access Key
Default region: us-east-1
Default output format: json
```

Verify your AWS identity:

```bash
aws sts get-caller-identity
```

> ⚠️ **Security Note:** Never commit AWS credentials, secrets, or Terraform state files to GitHub.

---

## 🚀 Terraform Deployment

Navigate to the Terraform directory:

```bash
cd terraform
```

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Format Terraform Files

```bash
terraform fmt
```

### 3. Validate the Configuration

```bash
terraform validate
```

### 4. Preview Infrastructure Changes

```bash
terraform plan
```

### 5. Deploy the Infrastructure

```bash
terraform apply
```

Confirm the deployment when prompted:

```text
yes
```

After successful deployment, Terraform will create the required AWS resources.

---

## 📤 Terraform Outputs

After deployment, you can retrieve important infrastructure information using Terraform outputs.

### API URL

```bash
terraform output api_url
```

### DynamoDB Table Name

```bash
terraform output dynamodb_table_name
```

### Create Task Lambda Name

```bash
terraform output create_task_lambda_name
```

### Get Tasks Lambda Name

```bash
terraform output get_tasks_lambda_name
```

---

## 🧪 Testing

After deployment, use the API URL returned by Terraform.

### Get Tasks

```bash
curl https://YOUR_API_URL/tasks
```

### Create Task

```bash
curl -X POST https://YOUR_API_URL/tasks \
  -H "Content-Type: application/json" \
  -d "{\"title\":\"Learn AWS\",\"description\":\"Build a serverless application\"}"
```

Then retrieve the tasks:

```bash
curl https://YOUR_API_URL/tasks
```

The newly created task should be returned from DynamoDB.

---

## 📊 Monitoring and Logging

AWS Lambda automatically integrates with **Amazon CloudWatch Logs**.

CloudWatch can be used to monitor:

* Lambda invocations
* Lambda errors
* Execution duration
* Application logs
* API activity
* Function performance

Lambda execution logs can be viewed from the AWS Management Console under:

```text
CloudWatch
    ↓
Log groups
    ↓
/aws/lambda/<lambda-function-name>
```

---

## 🔒 Security

The project uses **AWS IAM** to control access between Lambda and DynamoDB.

Lambda execution roles provide only the permissions required for:

* DynamoDB operations
* CloudWatch logging

### Security Best Practices

* Never commit AWS credentials.
* Never commit Terraform state files.
* Do not hard-code secrets.
* Use IAM roles instead of hard-coded credentials.
* Follow the **Principle of Least Privilege**.
* Keep `.terraform/` and sensitive Terraform files excluded using `.gitignore`.

---

## 🧹 Infrastructure Cleanup

When the infrastructure is no longer needed, destroy the AWS resources managed by Terraform:

```bash
terraform destroy
```

Confirm when prompted:

```text
yes
```

This removes the resources created by Terraform and helps prevent unnecessary AWS charges.

---

## 🔮 Future Improvements

Planned improvements include:

* [ ] Add `PUT /tasks/{id}`
* [ ] Add `DELETE /tasks/{id}`
* [ ] Add task status management
* [ ] Add authentication using Amazon Cognito
* [ ] Add automated unit tests
* [ ] Add CI/CD using GitHub Actions
* [ ] Add Terraform remote state
* [ ] Add development and production environments
* [ ] Add CloudWatch alarms
* [ ] Add custom API domain
* [ ] Add OpenAPI documentation

---

## 💻 Technologies

* **AWS Lambda**
* **Amazon API Gateway**
* **Amazon DynamoDB**
* **AWS IAM**
* **Amazon CloudWatch**
* **Terraform**
* **Python**
* **Git**
* **GitHub**

---

## 👨‍💻 Author

**Mohamed Yasser**

**DevOps / Cloud Engineer**

---

## 📄 License

This project is created for **educational and portfolio purposes**.
