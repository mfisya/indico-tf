resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = {
    Name = "rtb-prod"
  }
}

resource "aws_route" "routes" {
  count = length(var.routes)
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = var.routes[count.index].cidr_block
  gateway_id             = var.routes[count.index].gateway_id
}
