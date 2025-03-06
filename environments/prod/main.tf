# todo: vpc, eks, rds,

module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "prod"
}

module "subnet_private_a" {
  source                  = "../../modules/subnet-private"
  private_subnet_cidr     = "10.0.0.0/18"  
  private_availability_zones = ["ap-southeast-3b"] 
  
}

module "subnet_private_b" {
  source                  = "../../modules/subnet-private"
  private_subnet_cidr     = "10.0.64.0/18"  
  private_availability_zones = ["ap-southeast-3b"] 
  
}

module "subnet_public_a" {
  source                  = "../../modules/subnet-public"
  public_subnet_cidr  = "10.0.128.0/18"  
  availability_zones = ["ap-southeast-3a"] 
}

module "subnet_private_thirdparty" {
  source                  = "../../modules/subnet-private"
  private_subnet_cidr     = "10.0.192.0/19"  
  private_availability_zones = ["ap-southeast-3a"] 
}




module "eks_dev" {
  source = "../../modules/eks"
  
  cluster_name     = "dev-cluster"
  cluster_version  = "1.21"
  subnet_ids       = [module.subnet_private_a.private_subnet_id, module.subnet_private_b.private_subnet_id]
  vpc_id           = module.vpc.vpc_id
  desired_capacity = 3
  min_size         = 1
  max_size         = 5
  environment      = "prod"
}

module "rds" {
  source                = "../../modules/rds"
  db_identifier         = "rds-dev"
  db_name               = "dbadminname"
  db_user               = "dbadminuser"
  db_password           = var.db_password
  db_instance_class     = "db.t3.micro"
  allocated_storage     = 20
  engine               = "postgres"
  engine_version       = "12.0"
  subnet_ids           = [module.subnet_private_a.private_subnet_id, module.subnet_private_b.private_subnet_id]
}

resource "aws_eip" "public_nat" {
    domain = "vpc"
}

resource "aws_nat_gateway" "public_nat" {
    allocation_id = aws_eip.public_nat.id
    subnet_id     = module.subnet_private_a.private_subnet_id
}

resource "aws_route_table" "private" {
    vpc_id = module.vpc.vpc_id
    
}

resource "aws_route_table" "public" {
    vpc_id = module.vpc.vpc_id
    
}

data "aws_route_table" "private" {
  vpc_id = module.vpc.vpc_id
}

resource "aws_eip" "private_nat" {
    domain = "vpc"
}

resource "aws_nat_gateway" "private_nat" {
    allocation_id = aws_eip.private_nat.id
    subnet_id     = module.subnet_private_thirdparty.private_subnet_id
}

resource "aws_route" "public" { 
    route_table_id         = aws_route_table.private.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.public_nat.id
}

resource "aws_route" "private" { 
    route_table_id         = aws_route_table.private.id
    destination_cidr_block = "10.1.0.0/18"
    nat_gateway_id         = aws_nat_gateway.private_nat.id
}


resource "aws_route_table_association" "thidparty" {
    subnet_id      = module.subnet_private_thirdparty.private_subnet_id
    route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_a" {
    subnet_id      = module.subnet_private_a.private_subnet_id
    route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
    subnet_id      = module.subnet_private_b.private_subnet_id
    route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
    subnet_id      = module.subnet_public_a.subnet_id
    route_table_id = aws_route_table.public.id
}
