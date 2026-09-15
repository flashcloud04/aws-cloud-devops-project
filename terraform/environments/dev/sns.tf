resource "aws_sns_topic" "alerts" {
  name = "aws-cloud-devops-alerts"

  tags = {
    Name        = "aws-cloud-devops-alerts"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}