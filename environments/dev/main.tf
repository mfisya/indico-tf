# todo: vpc, eks, rds,

module "vpc_dev" {
  source   = "../../modules/vpc"
  vpc_cidr = "10.1.0.0/16"
  vpc_name = "dev"
}

module "subnet_private_dev" {
  source                  = "../../modules/subnet-private"
  private_subnet_cidr     = "10.1.0.0/16"  
  private_availability_zones = ["ap-southeast-3a", "ap-southeast-3b"] 
  
}

module "eks_dev" {
  source = "../../modules/eks"
  
  cluster_name     = "dev-cluster"
  cluster_version  = "1.21"
  subnet_ids       = [module.subnet_private_dev.private_subnet_id]
  vpc_id           = module.vpc_dev.vpc_id
  desired_capacity = 3
  min_size         = 1
  max_size         = 5
  environment      = "dev"
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
  subnet_ids           = [module.subnet_private_dev.private_subnet_id]
}

resource "aws_route_table" "private" {
    vpc_id = module.vpc_dev.vpc_id    
}

data "aws_route_table" "private" {
  vpc_id = module.vpc_dev.vpc_id
}

