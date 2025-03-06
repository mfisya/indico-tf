output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.rds_instance.endpoint
}

output "rds_identifier" {
  description = "RDS instance identifier"
  value       = aws_db_instance.rds_instance.identifier
}
