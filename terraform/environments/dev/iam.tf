resource "aws_iam_role" "ec2" {
  name = "aws-cloud-devops-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "aws-cloud-devops-ec2-role"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2" {
  name = "aws-cloud-devops-ec2-profile"
  role = aws_iam_role.ec2.name
}
resource "aws_iam_policy" "ec2_database_secret" {
  name        = "aws-cloud-devops-ec2-database-secret"
  description = "Allow EC2 application instances to read the database credentials secret"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetSecretValue"
        ]

        Resource = aws_secretsmanager_secret.db.arn
      }
    ]
  })

  tags = {
    Name        = "aws-cloud-devops-ec2-database-secret"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_database_secret" {
  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.ec2_database_secret.arn
}
resource "aws_iam_role_policy_attachment" "ec2_ecr_readonly" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}