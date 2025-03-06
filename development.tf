# todo: vpc, eks, rds

module "vpc_dev" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_hub_cidr
  vpc_name = var.vpc_hub_name
}

# module "eks_dev" {
#   source              = "./modules/eks"
#   region              = var.region
#   cluster_name        = var.eks_dev_cluster_name
#   cluster_version     = var.eks_dev_cluster_version
#   cluster_role_arn    = var.eks_dev_cluster_role_arn
#   node_group_name     = var.eks_dev_node_group_name
#   node_role_arn       = var.eks_dev_node_role_arn
#   subnet_ids          = var.eks_dev_subnet_ids
#   node_group_size     = var.eks_dev_node_group_size
#   node_instance_type  = var.eks_dev_node_instance_type
#   node_ami_id         = var.eks_dev_node_ami_id
#   vpc_id              = var.eks_dev_vpc_id
#   public_subnet_ids   = var.eks_dev_public_subnet_ids
#   node_ami_release_version = var.eks_dev_node_ami_release_version
# private_subnet_id        = var.eks_dev_private_subnet_id
# }
