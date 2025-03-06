# @TODO: route53 generated manually basedon NLB created from kubeernetes services

# @TODO: cloudfront

module "dev" {
  source = "./environments/dev"
  db_password = "your_password_here"
}

module "prod" {
  source = "./environments/prod"
  db_password = "your_password_here"
}

module "vpn" {
    source = "./infrastructures/vpn"         
    vpc_prod_id                   = module.prod.vpc_id
    vpc_dev_id                    = module.dev.vpc_id    
    rt_vpc_prod_id                = module.prod.rt_prod_id
    rt_vpc_dev_id                 = module.dev.rt_dev_id
}

module "waf" {
  source = "./infrastructures/security"
}

module "cicd-runner" {
  source = "./infrastructures/cicd"
  vpc_id = module.prod.vpc_id
}