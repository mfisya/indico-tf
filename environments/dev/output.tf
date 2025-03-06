output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "vpc_id" {
  value = module.vpc_dev.vpc_id
}

output "eks_cluster_id" {
  value = module.eks_dev.eks_cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks_dev.eks_cluster_endpoint
}

output "rt_dev_id" {
  value = data.aws_route_table.private.id
  
}