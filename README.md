# Serverless Task Manager

A serverless task management API built using AWS Lambda, Amazon API Gateway, Amazon DynamoDB, AWS IAM, Amazon CloudWatch, and Terraform.

The project demonstrates how to build and manage a serverless REST API using Infrastructure as Code (IaC), with AWS Lambda handling the application logic and DynamoDB providing persistent task storage.

---

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

# Solution Overview

The Serverless Task Manager is a REST API designed to create and retrieve tasks using a fully serverless AWS architecture.

The solution uses Amazon API Gateway as the entry point for HTTP requests. API Gateway routes requests to AWS Lambda functions, which process the application logic and communicate with Amazon DynamoDB for data storage.

The architecture eliminates the need to manage servers or virtual machines and allows the application to scale automatically based on demand.

The infrastructure is defined and managed using Terraform.

### Main request flow

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
