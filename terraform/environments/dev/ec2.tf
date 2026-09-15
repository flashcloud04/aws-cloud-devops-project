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

    dnf update -y
    dnf install -y nginx

    systemctl enable nginx
    systemctl start nginx

    cat > /usr/share/nginx/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
    <head>
      <title>AWS Cloud DevOps Project</title>
    </head>

    <body>
      <h1>AWS Cloud DevOps Project</h1>
      <p>Application successfully served by Amazon EC2.</p>
      <p>Infrastructure managed by Terraform.</p>
    </body>
    </html>
    HTML
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