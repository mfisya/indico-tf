
module "vpc_hub" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_hub_cidr
  vpc_name = var.vpc_hub_name
}

module "subnet_hub" {
  source              = "./modules/subnet-public"
  vpc_id              = module.vpc_hub.vpc_id
  public_subnet_cidr  = var.vpc_hub_public_subnet_cidr
  availability_zones  = var.vpc_hub_availability_zones
}

