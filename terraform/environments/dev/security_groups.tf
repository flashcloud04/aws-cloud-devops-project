# ============================================================
# Application Load Balancer Security Group
# ============================================================

resource "aws_security_group" "alb" {
  name        = "aws-cloud-devops-alb-sg"
  description = "Security group for the public Application Load Balancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "aws-cloud-devops-alb-sg"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}


# ============================================================
# EC2 Security Group
# ============================================================

resource "aws_security_group" "ec2" {
  name        = "aws-cloud-devops-ec2-sg"
  description = "Security group for private application EC2 instances"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "HTTP from Application Load Balancer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "aws-cloud-devops-ec2-sg"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}