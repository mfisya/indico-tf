
resource "aws_cloudwatch_log_group" "auditlog" {
    name              = "/aws/lambda/my-lambda-function"
    retention_in_days = 30
}

resource "aws_cloudwatch_log_metric_filter" "autditlog-filter" {
    name           = "example-metric-filter"
    pattern        = "{$.level = \"ERROR\"}"
    log_group_name = aws_cloudwatch_log_group.example.name

    metric_transformation {
        name      = "ErrorCount"
        namespace = "MyApp"
        value     = "1"
    }
}