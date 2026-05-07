resource "aws_sns_topic" "alerts_topic" {
  name = "cloudtech-alerts"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alerts_topic.arn
  protocol  = "email"
  endpoint  = "viktor.dmytrovych.ri.2024@lpnu.ua"
}

resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name          = "save-course-errors-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "Monitors errors in the save-course Lambda function"
  alarm_actions       = [aws_sns_topic.alerts_topic.arn]

  dimensions = {
    FunctionName = "cloudtech-dev-save-course"
  }
}

resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name          = "aws-billing-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "21600"
  statistic           = "Maximum"
  threshold           = "5"
  alarm_description   = "Billing alarm when AWS charges exceed $5"
  alarm_actions       = [aws_sns_topic.alerts_topic.arn]

  dimensions = {
    Currency = "USD"
  }
}