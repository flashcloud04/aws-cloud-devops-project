resource "aws_s3_bucket" "project" {
  bucket_prefix = "flashcloud-aws-devops-"

  tags = {
    Name        = "AWS Cloud DevOps Project"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}