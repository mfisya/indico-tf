output "dev_db_password" {
    value = module.dev.db_password
}

output "prod_db_password" {
    value = module.prod.db_password
}

output "vpn_vpc_prod_id" {
    value = module.vpn.vpc_prod_id
}

output "vpn_vpc_dev_id" {
    value = module.vpn.vpc_dev_id
}

output "vpn_rt_vpc_prod_id" {
    value = module.vpn.rt_vpc_prod_id
}

output "vpn_rt_vpc_dev_id" {
    value = module.vpn.rt_vpc_dev_id
}