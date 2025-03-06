provider "aws" {
  region = var.region
}

# Membuat Web ACL untuk WAF
resource "aws_wafv2_web_acl" "waf_acl" {
  name        = var.waf_name
  scope       = "CLOUDFRONT" # Scope untuk CloudFront, gunakan "REGIONAL" untuk ALB/API Gateway
  description = "Web ACL untuk melindungi aplikasi dengan aturan dasar"

  default_action {
    allow {} # Aksi default: izinkan semua trafik jika tidak cocok dengan aturan
  }

  # Aturan dasar untuk mencegah SQL Injection
  rule {
    name     = "SQLInjectionRule"
    priority = 1

    action {
      block {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "WAF-SQLInjectionRule"
      sampled_requests_enabled   = true
    }
  }

  # Aturan dasar untuk mencegah Cross-Site Scripting (XSS)
  rule {
    name     = "XSSRule"
    priority = 2

    action {
      block {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesXSSRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "WAF-XSSRule"
      sampled_requests_enabled   = true
    }
  }

  tags = {
    Environment = var.environment
  }

  # Integrasi dengan CloudFront
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "WAFMainMetrics"
    sampled_requests_enabled   = true
  }
}

# Menghubungkan Web ACL ke CloudFront Distribution (contoh)
resource "aws_cloudfront_distribution" "cf_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Distribution with WAF protection"
  default_root_object = "index.html"

  origin {
    domain_name = var.origin_domain
    origin_id   = "myOrigin"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "myOrigin"

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  web_acl_id = aws_wafv2_web_acl.waf_acl.arn
}

# Integrasi dengan CloudWatch Logs (opsional)
resource "aws_wafv2_web_acl_logging_configuration" "waf_logging" {
  log_destination_configs = [aws_s3_bucket.waf_logs.arn]
  resource_arn            = aws_wafv2_web_acl.waf_acl.arn
}

resource "aws_s3_bucket" "waf_logs" {
  bucket_prefix = "waf-logs"
}