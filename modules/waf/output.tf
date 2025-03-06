output "waf_acl_arn" {
  description = "ARN dari Web ACL yang dibuat"
  value       = aws_wafv2_web_acl.waf_acl.arn
}

output "cloudfront_domain_name" {
  description = "Domain name dari CloudFront distribution"
  value       = aws_cloudfront_distribution.cf_distribution.domain_name
}

output "s3_bucket_name" {
  description = "Nama bucket S3 untuk log WAF"
  value       = aws_s3_bucket.waf_logs.bucket
}