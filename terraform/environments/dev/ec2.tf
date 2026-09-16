# ============================================================
# Latest Amazon Linux 2023 AMI
# ============================================================

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


# ============================================================
# EC2 Launch Template
# ============================================================

resource "aws_launch_template" "app" {
  name_prefix   = "aws-cloud-devops-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2.name
  }

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  user_data = base64encode(<<-EOF
  #!/bin/bash

  set -e

  # Update packages
  dnf update -y

  # Install Docker
  dnf install -y docker

  # Start Docker
  systemctl enable docker
  systemctl start docker

  # Wait for Docker to be ready
  until docker info >/dev/null 2>&1; do
    sleep 2
  done

  # AWS region
  AWS_REGION="${var.aws_region}"

  # ECR repository
  ECR_REPO="${aws_ecr_repository.backend.repository_url}"

  # Login to ECR
  aws ecr get-login-password --region "$AWS_REGION" | \
    docker login --username AWS --password-stdin "$ECR_REPO"

  # Pull application image
  docker pull "$ECR_REPO:latest"

  # Retrieve database credentials from Secrets Manager
  SECRET_JSON=$(aws secretsmanager get-secret-value \
    --secret-id "${aws_secretsmanager_secret.db.id}" \
    --region "$AWS_REGION" \
    --query SecretString \
    --output text)

  DB_USERNAME=$(echo "$SECRET_JSON" | python3 -c 'import sys,json; print(json.load(sys.stdin)["username"])')
  DB_PASSWORD=$(echo "$SECRET_JSON" | python3 -c 'import sys,json; print(json.load(sys.stdin)["password"])')

  # RDS endpoint
 DB_HOST="${aws_db_instance.app.address}"

  # Remove old container if it exists
  docker rm -f aws-cloud-devops-backend 2>/dev/null || true

  # Start FastAPI application
  docker run -d \
    --name aws-cloud-devops-backend \
    --restart unless-stopped \
    -p 8000:8000 \
    -e DATABASE_URL="postgresql+psycopg://$DB_USERNAME:$DB_PASSWORD@$DB_HOST:5432/cloudapp" \
    "$ECR_REPO:latest"

EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "aws-cloud-devops-app"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }

  tags = {
    Name        = "aws-cloud-devops-launch-template"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}