# ============================================================
# Application Load Balancer
# ============================================================

resource "aws_lb" "app" {
  name               = "aws-cloud-devops-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  tags = {
    Name        = "aws-cloud-devops-alb"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}


# ============================================================
# Target Group
# ============================================================

resource "aws_lb_target_group" "app" {
  name     = "aws-cloud-devops-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
  }

  tags = {
    Name        = "aws-cloud-devops-tg"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}


# ============================================================
# HTTP Listener
# ============================================================

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}