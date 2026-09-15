AWS Cloud DevOps Project

A production-style AWS Cloud and DevOps portfolio project demonstrating Infrastructure as Code, networking, security, compute, databases, monitoring, containerization, and CI/CD.

The project is built incrementally using Terraform, AWS, Git, GitHub, Docker, and GitHub Actions, with the goal of creating a reproducible and maintainable cloud application environment.

Project Goals

This project is designed to demonstrate practical skills in:

AWS cloud architecture
Infrastructure as Code with Terraform
AWS networking and security
IAM and least-privilege access
EC2 and Auto Scaling
Application Load Balancing
PostgreSQL on Amazon RDS
AWS Secrets Manager
CloudWatch monitoring
SNS notifications
Docker and containerization
Amazon ECR
Amazon ECS / Fargate
GitHub Actions CI/CD
Serverless AWS services
DNS, HTTPS and CloudFront
Terraform modules and remote state
Cost awareness and cloud security

The project is intentionally built in stages so that each AWS service has a practical purpose rather than being added simply to increase the number of services used.

Architecture
Current Infrastructure
                         INTERNET
                            │
                            ▼
                ┌─────────────────────┐
                │ Application Load    │
                │ Balancer            │
                │ Public Subnets       │
                └──────────┬──────────┘
                           │
                           │ HTTP :80
                           ▼
              ┌────────────────────────────┐
              │      Auto Scaling Group     │
              │                            │
              │   EC2       EC2            │
              │ Private Subnet A/B         │
              └────────────┬───────────────┘
                           │
                           │ PostgreSQL :5432
                           ▼
                 ┌─────────────────────┐
                 │    RDS PostgreSQL   │
                 │    Private Subnets  │
                 └─────────────────────┘
                           ▲
                           │
                  Secrets Manager

       CloudWatch ───────► SNS Alerts

       S3 ───────────────► Project Storage
AWS Infrastructure
Networking

The project currently contains:

VPC
CIDR: 10.0.0.0/16
DNS support
DNS hostnames
Internet Gateway
Two public subnets
Two private subnets
NAT Gateway
Elastic IP
Public route table
Private route table
Route table associations

The public subnets are used by the Application Load Balancer.

The private subnets are used by the application EC2 instances and RDS.

Compute

The application compute layer currently includes:

EC2 Launch Template
Amazon Linux 2023
t3.micro
Auto Scaling Group
Desired capacity: 2
Minimum capacity: 2
Maximum capacity: 2
EC2 instances deployed across two Availability Zones
Nginx demonstration application

The EC2 instances are deployed in private subnets.

Load Balancing

The project uses:

Application Load Balancer
Public subnets
Target Group
HTTP listener
Health checks

Traffic flow:

Internet
   ↓
ALB :80
   ↓
Target Group
   ↓
EC2 :80

The ALB has been verified to successfully route traffic to the EC2 instances.

Security

Security groups are designed around application tiers:

Internet
   ↓
ALB Security Group
   ↓
EC2 Security Group
   ↓
RDS Security Group

Current access rules include:

Internet → ALB HTTP/HTTPS
ALB → EC2 HTTP
EC2 → RDS PostgreSQL 5432
Direct Internet → EC2 blocked
Direct Internet → RDS blocked
IAM

EC2 uses an IAM role with:

AmazonSSMManagedInstanceCore

This allows management through AWS Systems Manager without requiring traditional SSH access.

Future iterations will introduce more granular least-privilege IAM policies for application access to AWS services.

Database

The project uses:

Amazon RDS PostgreSQL
Database name: cloudapp
PostgreSQL port: 5432
Private subnets
Encryption enabled
Public accessibility disabled

The database is intentionally not exposed directly to the Internet.

Secrets Management

Database credentials are managed using:

AWS Secrets Manager

Terraform generates the database password using the Random provider and stores the credentials in Secrets Manager.

Database passwords are not exposed through Terraform outputs.

Future application code will retrieve the credentials securely through Secrets Manager rather than hard-coding them.

Monitoring & Alerting

Current monitoring includes:

CloudWatch
EC2 CPU utilization alarm
ALB unhealthy-host alarm
SNS
Infrastructure alert SNS topic
CloudWatch alarms configured to publish to SNS

The monitoring layer will be expanded as the application architecture grows.

Terraform

Terraform is used to provision and manage the AWS infrastructure.

Current Terraform structure:

terraform/
├── environments/
│   └── dev/
│       ├── versions.tf
│       ├── providers.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── main.tf
│       ├── s3.tf
│       ├── vpc.tf
│       ├── security_groups.tf
│       ├── iam.tf
│       ├── alb.tf
│       ├── ec2.tf
│       ├── autoscaling.tf
│       ├── monitoring.tf
│       ├── sns.tf
│       ├── database_security.tf
│       ├── secrets.tf
│       └── rds.tf
│
└── modules/

Terraform files are separated by AWS service/layer rather than placing the entire infrastructure in a single file.

Terraform Workflow

The standard workflow is:

terraform init
terraform fmt
terraform validate
terraform plan
terraform apply

To inspect outputs:

terraform output

To destroy the temporary environment:

terraform destroy

Always review the Terraform plan before applying changes.

AWS Sandbox Strategy

This project is being developed using a temporary AWS sandbox environment.

The sandbox resources may be deleted when the sandbox session expires.

Therefore:

GitHub
   ↓
Permanent source of truth

Terraform
   ↓
Reproducible infrastructure

AWS Sandbox
   ↓
Temporary execution environment

The infrastructure is designed to be recreated from Terraform rather than relying on manually configured AWS resources.

Repository Structure
aws-cloud-devops-project/
│
├── application/
│   ├── backend/
│   └── frontend/
│
├── docker/
│
├── docs/
│   └── progress.md
│
├── modules/
│
├── terraform/
│   ├── environments/
│   │   └── dev/
│   └── modules/
│
├── .github/
│   └── workflows/
│
├── .gitignore
└── README.md
Development Roadmap
Completed

Git and GitHub setup

Terraform setup

AWS CLI setup

S3 bucket

VPC

Public and private subnets

Internet Gateway

NAT Gateway

Route tables

IAM EC2 role

Security groups

EC2 Launch Template

Application Load Balancer

Target Group

Auto Scaling Group

Nginx application

CloudWatch alarms

SNS alerts

RDS PostgreSQL

Secrets Manager

End-to-end ALB → EC2 verification

Planned
Application

Build Python/FastAPI backend

Build frontend

PostgreSQL integration

REST API

Application health checks

Application logging

Automated tests

Docker

Dockerfile

Containerized backend

Docker Compose

Local container testing

ECR

Amazon ECR repository

Docker image tagging

Image push

Image scanning

Lifecycle policy

ECS / Fargate

ECS cluster

Task definition

ECS service

Fargate deployment

ALB → ECS integration

CI/CD

GitHub Actions

Automated testing

Linting

Docker build

ECR push

ECS deployment

Deployment verification

Serverless

Lambda

API Gateway

DynamoDB

SQS

EventBridge

DNS / HTTPS / CDN

Route 53

ACM

HTTPS

CloudFront

Custom domain

Terraform Advanced

Terraform modules

Environment separation

Remote state

S3 backend

State locking

Terraform CI validation

Automated Terraform plan

Security & Operations

Least-privilege IAM

KMS

CloudTrail

Advanced CloudWatch monitoring

AWS Budgets

Cost optimization

Well-Architected review

Disaster recovery considerations

Project Principles
Infrastructure as Code

AWS infrastructure should be reproducible through Terraform.

Security First

Resources should use private networking, security groups, IAM roles, encryption and least-privilege access wherever appropriate.

Automation

Manual deployment steps should gradually be replaced with automated CI/CD workflows.

Observability

Applications and infrastructure should expose meaningful metrics, logs and alerts.

Cost Awareness

The project is designed for learning and portfolio development, so unnecessary AWS resources should be avoided and temporary resources should be destroyed when no longer required.

Reproducibility

The project should be capable of rebuilding the infrastructure from the GitHub repository rather than depending on manually created AWS resources.

Current Status

Infrastructure foundation complete.

The project currently has:

Terraform
   │
   ├── S3
   ├── VPC
   ├── Networking
   ├── IAM
   ├── Security Groups
   ├── ALB
   ├── EC2
   ├── Auto Scaling
   ├── CloudWatch
   ├── SNS
   ├── RDS PostgreSQL
   └── Secrets Manager

The next major milestone is:

Build the real Python/FastAPI application and connect it securely to PostgreSQL.
