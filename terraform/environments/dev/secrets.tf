# ============================================================
# Database Password
# ============================================================

resource "random_password" "db" {
  length  = 24
  special = true
}


# ============================================================
# Secrets Manager
# ============================================================

resource "aws_secretsmanager_secret" "db" {
  name = "aws-cloud-devops/database"

  description = "Credentials for the AWS Cloud DevOps PostgreSQL database"

  tags = {
    Name        = "aws-cloud-devops-database-secret"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id

  secret_string = jsonencode({
    username = "appadmin"
    password = random_password.db.result
  })
}