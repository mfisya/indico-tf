resource "aws_route_table" "rtb-prod" {
  vpc_id = var.vpc_id
  # ...additional configuration...
}

output "route_table_id" {
  description = "The ID of the route table"
  value       = aws_route_table.rtb-prod.id
}
