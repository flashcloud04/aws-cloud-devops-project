AWS Cloud DevOps Project — Progress
Project Goal

Build a production-style AWS Cloud/DevOps application demonstrating:

AWS infrastructure
Terraform Infrastructure as Code
Networking and security
Compute and load balancing
Database and secrets management
Monitoring and alerting
Docker and containerization
ECR and ECS/Fargate
GitHub Actions CI/CD
Serverless architecture
CloudFront, Route 53 and ACM
Security, reliability and cost-awareness
Environment
AWS Region: us-east-1
Terraform: 1.16.2
Terraform Provider: AWS ~> 6.0
Source Control: Git + GitHub
AWS Environment: Pluralsight AWS Sandbox
Terraform State: Local for learning phase

Pluralsight AWS Sandbox resources are temporary. GitHub and Terraform code are the permanent source of truth.

Completed Milestones
Day 0 — Project Setup

Git installed and configured

GitHub repository created

Local project structure created

.gitignore configured

Terraform installed

AWS CLI installed and configured

AWS credentials kept outside the repository

Terraform initialized

Initial project committed and pushed to GitHub

Day 1 — Terraform + S3 + Networking
Terraform

Terraform provider configuration

Terraform variables

Terraform outputs

Terraform formatting

Terraform validation

Terraform plan/apply workflow

.terraform.lock.hcl committed

Terraform state excluded from Git

S3

S3 bucket created with Terraform

S3 bucket tagged

S3 bucket outputs configured

S3 bucket verified using AWS CLI

VPC Networking

VPC created

VPC CIDR 10.0.0.0/16

DNS support enabled

DNS hostnames enabled

Internet Gateway

Public subnet A

Public subnet B

Private subnet A

Private subnet B

Elastic IP for NAT Gateway

NAT Gateway

Public route table

Private route table

Public route → Internet Gateway

Private route → NAT Gateway

Route table associations

Networking verified using AWS CLI

Day 2 — IAM + EC2 + Load Balancing
IAM

EC2 IAM role

EC2 instance profile

AmazonSSMManagedInstanceCore policy

IAM-based EC2 management without SSH keys

Security Groups

ALB security group

EC2 security group

Internet → ALB HTTP access

ALB → EC2 HTTP access

Direct Internet → EC2 access blocked

EC2

Amazon Linux 2023 AMI discovery

EC2 Launch Template

t3.micro instance configuration

Nginx installation using user_data

Custom application landing page

Application Load Balancer

Application Load Balancer

Public ALB subnets

Target Group

HTTP listener

ALB health checks

Auto Scaling

Auto Scaling Group

Desired capacity: 2

Minimum capacity: 2

Maximum capacity: 2

EC2 instances distributed across private subnets

EC2 instances registered with ALB target group

ELB health checks enabled

End-to-End Test

Both EC2 instances InService

Both EC2 instances Healthy

ALB successfully routed traffic to EC2

Application tested using curl

Monitoring & Alerting
CloudWatch

CloudWatch EC2 CPU alarm

EC2 CPU threshold configured

CloudWatch ALB unhealthy-host alarm

ALB target health monitoring

SNS

SNS alert topic

CloudWatch alarms connected to SNS

Database & Secrets
RDS

PostgreSQL RDS instance

RDS private deployment

RDS subnet group

RDS security group

PostgreSQL port 5432

EC2 → RDS access only

RDS encryption enabled

RDS verified as available

RDS verified as not publicly accessible

Secrets Manager

Database secret created

Random database password generated

Database credentials stored in Secrets Manager

Database password excluded from Terraform outputs

Current Architecture
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
Terraform Structure
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
Upcoming Milestones
Application Development

Backend API

Frontend application

PostgreSQL database integration

Health endpoint

CRUD/API functionality

Application configuration

Application logging

Error handling

Testing

Docker

Dockerfile

Local container build

Docker Compose for local development

Containerized backend

Containerized frontend

Amazon ECR

ECR repository

Docker image tagging

Image push to ECR

ECR lifecycle policy

Image scanning

ECS / Fargate

ECS cluster

ECS task definition

ECS service

Fargate deployment

ALB → ECS integration

ECS security groups

ECS IAM roles

CI/CD

GitHub Actions

CI workflow

Automated testing

Docker image build

ECR push

Deployment workflow

Environment variables/secrets

Deployment verification

Serverless

Lambda function

API Gateway

DynamoDB

Lambda IAM permissions

API integration

CloudWatch Lambda logs

Messaging & Events

SQS

SNS advanced integrations

EventBridge

Event-driven workflow

Dead-letter queue

CDN / DNS / HTTPS

Route 53

ACM certificate

CloudFront

HTTPS

Custom domain

S3 frontend hosting

Security

Least-privilege IAM

Secrets Manager integration

KMS

CloudTrail

Security best practices

IAM policy review

Network security review

Terraform Advanced

Terraform modules

Reusable networking module

Reusable compute module

Reusable database module

Environment separation

Remote S3 backend

State locking

Terraform CI validation

Terraform plan in GitHub Actions

Cost & Reliability

AWS Budgets

Cost Explorer

Resource tagging strategy

Well-Architected review

High availability review

Disaster recovery considerations

Sandbox cleanup procedure

Verification Philosophy

Every infrastructure milestone should follow:

Terraform Code
      ↓
terraform fmt
      ↓
terraform validate
      ↓
terraform plan
      ↓
Review changes
      ↓
terraform apply
      ↓
AWS CLI / Application verification
      ↓
Git commit
      ↓
Git push
Important Sandbox Rule

The Pluralsight AWS Sandbox is temporary.

Therefore:

GitHub
  = Permanent source of truth

Terraform Code
  = Permanent infrastructure definition

Terraform State
  = Temporary learning state

Pluralsight AWS Sandbox
  = Temporary execution environment

The infrastructure should always be reproducible from the Terraform code.

Current Status

Completed through: RDS + Secrets Manager + CloudWatch/SNS

Next milestone:

Build the actual application and connect it to PostgreSQL.
