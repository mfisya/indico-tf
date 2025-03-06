# resource "aws_subnet" "private-prod" {
#   vpc_id            = var.vpc_id
#   cidr_block        = var.private_subnet_cidr
#   availability_zone = var.private_availability_zones[0]
#   map_public_ip_on_launch = false

#   tags = {
#     Name = "${var.vpc_id}-private-subnet"
#   }
# }

# resource "aws_route_table" "private" {
#   vpc_id = var.vpc_id

#   tags = {
#     Name = "${var.vpc_id}-private-route-table"
#   }
# }

# resource "aws_route_table_association" "private" {
#   subnet_id      = aws_subnet.private-prod.id
#   route_table_id = var.route_table_id
# }

# output "subnet_id" {
#   value = aws_subnet.private.id
# }
