resource "aws_cloudwatch_log_group" "ec2" {
  name              = "/aws/ec2/${var.project}"
  retention_in_days = 14
  tags = {
    Project = var.project
  }
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "HighCPU-${var.project}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "This alarm triggers when EC2 CPU > 70%"
  dimensions = {
    InstanceId = aws_instance.app.id
  }
  alarm_actions = []
}