module "vpc_hub" {
  source   = "../../modules/vpc"
  vpc_cidr = var.vpc_hub_cidr
  vpc_name = var.vpc_hub_name
}

resource "aws_key_pair" "teleport_key" {
  key_name   = "teleport-key"
  public_key = file("~/.ssh/id_rsa.pub") # Ensure you have this key generated
}

resource "aws_security_group" "teleport_sg" {
  name        = "teleport-security-group"
  description = "Allow Teleport and SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict this in production
  }

  ingress {
    from_port   = 3023
    to_port     = 3025
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "teleport" {
  ami           = "ami-0c55b159cbfafe1f0" # Change to a valid Ubuntu AMI ID
  instance_type = "t3.medium"
  key_name      = aws_key_pair.teleport_key.key_name
  security_groups = [aws_security_group.teleport_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update && sudo apt install -y curl
              curl https://get.gravitational.com/teleport.tar.gz | tar -xz
              sudo mv teleport /usr/local/bin/
              sudo teleport start &
              EOF

  tags = {
    Name = "Teleport-Server"
  }
}

module "subnet_hub" {
  source              = "../../modules/subnet-public"
  vpc_id              = module.vpc_hub.vpc_id
  public_subnet_cidr  = var.vpc_hub_public_subnet_cidr
  availability_zones  = var.vpc_hub_availability_zones
}

# VPC Peering: vpc_vpn <-> vpc_prod
resource "aws_vpc_peering_connection" "vpn_to_prod" {
  vpc_id      = module.vpc_hub.vpc_id
  peer_vpc_id = var.vpc_prod_id
  auto_accept = true

  tags = {
    Name = "vpn-to-prod"
  }
}

# VPC Peering: vpc_vpn <-> vpc_dev
resource "aws_vpc_peering_connection" "vpn_to_dev" {
  vpc_id      = module.vpc_hub.vpc_id
  peer_vpc_id = var.vpc_dev_id
  auto_accept = true

  tags = {
    Name = "vpn-to-dev"
  }
}

resource "aws_route_table" "public" {
    vpc_id = module.vpc_hub.vpc_id
}

data "aws_route_table" "public" {
  vpc_id = module.vpc_hub.vpc_id  
}


# Route vpc_vpn -> vpc_prod
resource "aws_route" "route_vpn_to_prod" {
  route_table_id            = data.aws_route_table.public.id
  destination_cidr_block    = var.vpc_prod_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpn_to_prod.id
}

# Route vpc_vpn -> vpc_dev
resource "aws_route" "route_vpn_to_dev" {
  route_table_id            = data.aws_route_table.public.id
  destination_cidr_block    = var.vpc_dev_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpn_to_dev.id
}

# Route vpc_prod -> vpc_vpn
resource "aws_route" "route_prod_to_vpn" {
  route_table_id            = var.rt_vpc_prod_id
  destination_cidr_block    = var.vpc_hub_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpn_to_prod.id
}

# Route vpc_dev -> vpc_vpn
resource "aws_route" "route_dev_to_vpn" {
  route_table_id            = var.rt_vpc_dev_id
  destination_cidr_block    = var.vpc_hub_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpn_to_dev.id
}