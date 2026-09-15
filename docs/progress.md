# AWS Cloud DevOps Project — Progress

## Project Goal

Build a production-style AWS Cloud/DevOps application demonstrating:

* AWS infrastructure
* Terraform Infrastructure as Code
* Networking and security
* Compute and load balancing
* Database and secrets management
* Monitoring and alerting
* Docker and containerization
* ECR and ECS/Fargate
* GitHub Actions CI/CD
* Serverless architecture
* CloudFront, Route 53 and ACM
* Security, reliability and cost-awareness

---

## Environment

* AWS Region: `us-east-1`
* Terraform: `1.16.2`
* Terraform Provider: AWS `~> 6.0`
* Source Control: Git + GitHub
* AWS Environment: Pluralsight AWS Sandbox
* Terraform State: Local for learning phase

> Pluralsight AWS Sandbox resources are temporary. GitHub and Terraform code are the permanent source of truth.

---

# Completed Milestones

## Day 0 — Project Setup

* [x] Git installed and configured
* [x] GitHub repository created
* [x] Local project structure created
* [x] `.gitignore` configured
* [x] Terraform installed
* [x] AWS CLI installed and configured
* [x] AWS credentials kept outside the repository
* [x] Terraform initialized
* [x] Initial project committed and pushed to GitHub

---

## Day 1 — Terraform + S3 + Networking

### Terraform

* [x] Terraform provider configuration
* [x] Terraform variables
* [x] Terraform outputs
* [x] Terraform formatting
* [x] Terraform validation
* [x] Terraform plan/apply workflow
* [x] `.terraform.lock.hcl` committed
* [x] Terraform state excluded from Git

### S3

* [x] S3 bucket created with Terraform
* [x] S3 bucket tagged
* [x] S3 bucket outputs configured
* [x] S3 bucket verified using AWS CLI

### VPC Networking

* [x] VPC created
* [x] VPC CIDR `10.0.0.0/16`
* [x] DNS support enabled
* [x] DNS hostnames enabled
* [x] Internet Gateway
* [x] Public subnet A
* [x] Public subnet B
* [x] Private subnet A
* [x] Private subnet B
* [x] Elastic IP for NAT Gateway
* [x] NAT Gateway
* [x] Public route table
* [x] Private route table
* [x] Public route → Internet Gateway
* [x] Private route → NAT Gateway
* [x] Route table associations
* [x] Networking verified using AWS CLI

---

## Day 2 — IAM + EC2 + Load Balancing

### IAM

* [x] EC2 IAM role
* [x] EC2 instance profile
* [x] AmazonSSMManagedInstanceCore policy
* [x] IAM-based EC2 management without SSH keys

### Security Groups

* [x] ALB security group
* [x] EC2 security group
* [x] Internet → ALB HTTP access
* [x] ALB → EC2 HTTP access
* [x] Direct Internet → EC2 access blocked

### EC2

* [x] Amazon Linux 2023 AMI discovery
* [x] EC2 Launch Template
* [x] `t3.micro` instance configuration
* [x] Nginx installation using `user_data`
* [x] Custom application landing page

### Application Load Balancer

* [x] Application Load Balancer
* [x] Public ALB subnets
* [x] Target Group
* [x] HTTP listener
* [x] ALB health checks

### Auto Scaling

* [x] Auto Scaling Group
* [x] Desired capacity: 2
* [x] Minimum capacity: 2
* [x] Maximum capacity: 2
* [x] EC2 instances distributed across private subnets
* [x] EC2 instances registered with ALB target group
* [x] ELB health checks enabled

### End-to-End Test

* [x] Both EC2 instances `InService`
* [x] Both EC2 instances `Healthy`
* [x] ALB successfully routed traffic to EC2
* [x] Application tested using `curl`

---

## Monitoring & Alerting

### CloudWatch

* [x] CloudWatch EC2 CPU alarm
* [x] EC2 CPU threshold configured
* [x] CloudWatch ALB unhealthy-host alarm
* [x] ALB target health monitoring

### SNS

* [x] SNS alert topic
* [x] CloudWatch alarms connected to SNS

---

## Database & Secrets

### RDS

* [x] PostgreSQL RDS instance
* [x] RDS private deployment
* [x] RDS subnet group
* [x] RDS security group
* [x] PostgreSQL port `5432`
* [x] EC2 → RDS access only
* [x] RDS encryption enabled
* [x] RDS verified as `available`
* [x] RDS verified as not publicly accessible

### Secrets Manager

* [x] Database secret created
* [x] Random database password generated
* [x] Database credentials stored in Secrets Manager
* [x] Database password excluded from Terraform outputs

---

# Current Architecture

```text
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
```

---

# Terraform Structure

```text
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
```

---

# Upcoming Milestones

## Application Development

* [ ] Backend API
* [ ] Frontend application
* [ ] PostgreSQL database integration
* [ ] Health endpoint
* [ ] CRUD/API functionality
* [ ] Application configuration
* [ ] Application logging
* [ ] Error handling
* [ ] Testing

## Docker

* [ ] Dockerfile
* [ ] Local container build
* [ ] Docker Compose for local development
* [ ] Containerized backend
* [ ] Containerized frontend

## Amazon ECR

* [ ] ECR repository
* [ ] Docker image tagging
* [ ] Image push to ECR
* [ ] ECR lifecycle policy
* [ ] Image scanning

## ECS / Fargate

* [ ] ECS cluster
* [ ] ECS task definition
* [ ] ECS service
* [ ] Fargate deployment
* [ ] ALB → ECS integration
* [ ] ECS security groups
* [ ] ECS IAM roles

## CI/CD

* [ ] GitHub Actions
* [ ] CI workflow
* [ ] Automated testing
* [ ] Docker image build
* [ ] ECR push
* [ ] Deployment workflow
* [ ] Environment variables/secrets
* [ ] Deployment verification

## Serverless

* [ ] Lambda function
* [ ] API Gateway
* [ ] DynamoDB
* [ ] Lambda IAM permissions
* [ ] API integration
* [ ] CloudWatch Lambda logs

## Messaging & Events

* [ ] SQS
* [ ] SNS advanced integrations
* [ ] EventBridge
* [ ] Event-driven workflow
* [ ] Dead-letter queue

## CDN / DNS / HTTPS

* [ ] Route 53
* [ ] ACM certificate
* [ ] CloudFront
* [ ] HTTPS
* [ ] Custom domain
* [ ] S3 frontend hosting

## Security

* [ ] Least-privilege IAM
* [ ] Secrets Manager integration
* [ ] KMS
* [ ] CloudTrail
* [ ] Security best practices
* [ ] IAM policy review
* [ ] Network security review

## Terraform Advanced

* [ ] Terraform modules
* [ ] Reusable networking module
* [ ] Reusable compute module
* [ ] Reusable database module
* [ ] Environment separation
* [ ] Remote S3 backend
* [ ] State locking
* [ ] Terraform CI validation
* [ ] Terraform plan in GitHub Actions

## Cost & Reliability

* [ ] AWS Budgets
* [ ] Cost Explorer
* [ ] Resource tagging strategy
* [ ] Well-Architected review
* [ ] High availability review
* [ ] Disaster recovery considerations
* [ ] Sandbox cleanup procedure

---

# Verification Philosophy

Every infrastructure milestone should follow:

```text
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
```

---

# Important Sandbox Rule

The Pluralsight AWS Sandbox is temporary.

Therefore:

```text
GitHub
  = Permanent source of truth

Terraform Code
  = Permanent infrastructure definition

Terraform State
  = Temporary learning state

Pluralsight AWS Sandbox
  = Temporary execution environment
```

The infrastructure should always be reproducible from the Terraform code.

---

# Current Status

**Completed through: RDS + Secrets Manager + CloudWatch/SNS**

Next milestone:

**Build the actual application and connect it to PostgreSQL.**
