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