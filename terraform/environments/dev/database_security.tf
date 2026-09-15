# ============================================================
# RDS Security Group
# ============================================================

resource "aws_security_group" "rds" {
  name        = "aws-cloud-devops-rds-sg"
  description = "Security group for the private RDS PostgreSQL database"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "PostgreSQL from application EC2 instances"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "aws-cloud-devops-rds-sg"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}