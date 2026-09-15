# ============================================================
# RDS Subnet Group
# ============================================================

resource "aws_db_subnet_group" "app" {
  name = "aws-cloud-devops-db-subnet-group"

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = {
    Name        = "aws-cloud-devops-db-subnet-group"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}


# ============================================================
# RDS PostgreSQL
# ============================================================

resource "aws_db_instance" "app" {
  identifier = "aws-cloud-devops-postgres"

  engine = "postgres"

  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  max_allocated_storage = 20
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = "cloudapp"
  username = "appadmin"
  password = random_password.db.result

  port = 5432

  db_subnet_group_name = aws_db_subnet_group.app.name

  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  publicly_accessible = false

  backup_retention_period = 0

  deletion_protection = false

  skip_final_snapshot = true

  apply_immediately = true

  tags = {
    Name        = "aws-cloud-devops-postgres"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}