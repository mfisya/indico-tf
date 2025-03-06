resource "aws_subnet" "public" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_cidr
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "public-subnet"
  }

  count = length(var.availability_zones)
}


