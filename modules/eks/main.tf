# provider "aws" {
#   region = var.region
# }

# resource "aws_eks_cluster" "eks_cluster" {
#   name     = var.cluster_name
#   role_arn = var.cluster_role_arn

#   vpc_config {
#     subnet_ids = var.private_subnet_id
#   }

#   version = var.cluster_version
# }

# resource "aws_eks_node_group" "eks_node_group" {
#   cluster_name    = aws_eks_cluster.eks_cluster.name
#   node_group_name = var.node_group_name
#   node_role_arn   = var.node_role_arn
#   subnet_ids      = var.private_subnet_id

#   scaling_config {
#     desired_size = var.node_group_size
#     max_size     = var.node_group_size + 2
#     min_size     = var.node_group_size - 2
#   }

# instance_types = [var.node_instance_type]
#   ami_type      = "CUSTOM"
# release_version = var.node_ami_release_version
# }

