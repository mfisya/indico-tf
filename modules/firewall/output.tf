output "firewall_arn" {
  description = "ARN dari firewall yang dibuat"
  value       = aws_networkfirewall_firewall.firewall.arn
}

output "s3_bucket_name" {
  description = "Nama bucket S3 untuk log firewall"
  value       = aws_s3_bucket.firewall_logs.bucket
}