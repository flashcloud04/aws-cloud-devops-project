output "s3_bucket_name" {
  description = "Name of the project S3 bucket"
  value       = aws_s3_bucket.project.id
}

output "s3_bucket_arn" {
  description = "ARN of the project S3 bucket"
  value       = aws_s3_bucket.project.arn
}

output "vpc_id" {
  description = "ID of the project VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the project VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]
}

output "availability_zones" {
  description = "Availability zones used by the project"
  value       = data.aws_availability_zones.available.names
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.main.id
}
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.app.dns_name
}

output "alb_url" {
  description = "HTTP URL of the application"
  value       = "http://${aws_lb.app.dns_name}"
}

output "autoscaling_group_name" {
  description = "Name of the application Auto Scaling Group"
  value       = aws_autoscaling_group.app.name
}

output "launch_template_id" {
  description = "ID of the EC2 launch template"
  value       = aws_launch_template.app.id
}

output "ec2_iam_role" {
  description = "IAM role attached to EC2 instances"
  value       = aws_iam_role.ec2.name
}
output "sns_alert_topic_arn" {
  description = "SNS topic ARN used for infrastructure alerts"
  value       = aws_sns_topic.alerts.arn
}

output "ec2_cpu_alarm_name" {
  description = "CloudWatch alarm for high EC2 CPU utilization"
  value       = aws_cloudwatch_metric_alarm.ec2_cpu_high.alarm_name
}

output "alb_unhealthy_hosts_alarm_name" {
  description = "CloudWatch alarm for unhealthy ALB targets"
  value       = aws_cloudwatch_metric_alarm.alb_unhealthy_hosts.alarm_name
}
output "rds_identifier" {
  description = "RDS PostgreSQL instance identifier"
  value       = aws_db_instance.app.identifier
}

output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.app.address
}

output "rds_port" {
  description = "RDS PostgreSQL port"
  value       = aws_db_instance.app.port
}

output "rds_database_name" {
  description = "RDS PostgreSQL database name"
  value       = aws_db_instance.app.db_name
}

output "database_secret_arn" {
  description = "ARN of the database credentials secret"
  value       = aws_secretsmanager_secret.db.arn
}