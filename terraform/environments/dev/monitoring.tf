# ============================================================
# EC2 CPU Utilization Alarm
# ============================================================

resource "aws_cloudwatch_metric_alarm" "ec2_cpu_high" {
  alarm_name          = "aws-cloud-devops-ec2-cpu-high"
  alarm_description   = "Triggers when EC2 CPU utilization is consistently high"
  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 70

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app.name
  }

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  treat_missing_data = "notBreaching"

  tags = {
    Name        = "aws-cloud-devops-ec2-cpu-high"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}


# ============================================================
# ALB Unhealthy Host Alarm
# ============================================================

resource "aws_cloudwatch_metric_alarm" "alb_unhealthy_hosts" {
  alarm_name        = "aws-cloud-devops-alb-unhealthy-hosts"
  alarm_description = "Triggers when the ALB detects unhealthy targets"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2
  metric_name        = "UnHealthyHostCount"
  namespace          = "AWS/ApplicationELB"
  period             = 60
  statistic          = "Maximum"
  threshold          = 0

  dimensions = {
    TargetGroup  = aws_lb_target_group.app.arn_suffix
    LoadBalancer = aws_lb.app.arn_suffix
  }

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  treat_missing_data = "notBreaching"

  tags = {
    Name        = "aws-cloud-devops-alb-unhealthy-hosts"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}