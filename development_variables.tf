# # Provider configuration
# variable "region" {
#   description = "AWS region to deploy the EKS cluster"
#   type        = string
#   default     = "ap-southeast-1"
# }

# # Cluster configuration
# variable "eks_dev_cluster_name" {
#   description = "Name of the EKS cluster"
#   type        = string
#   default     = "eks-dev-cluster"
# }

# variable "eks_dev_cluster_version" {
#   description = "Kubernetes version for the EKS cluster"
#   type        = string
#   default     = "1.28"
# }

# variable "eks_dev_cluster_role_arn" {
#   description = "ARN of the IAM role that provides permissions for the Kubernetes control plane"
#   type        = string
# }

# # Node group configuration
# variable "eks_dev_node_group_name" {
#   description = "Name of the EKS node group"
#   type        = string
#   default     = "eks-dev-nodes"
# }

# variable "eks_dev_node_role_arn" {
#   description = "ARN of the IAM role for EKS node group"
#   type        = string
# }

# variable "eks_dev_node_group_size" {
#   description = "Size of the node group (min, max, desired capacity)"
#   type        = object({
#     min_size     = 1
#     max_size     = 4
#     desired_size = number
#   })
#   default = {
#     min_size     = 2
#     max_size     = 4
#     desired_size = 2
#   }
# }

# variable "eks_dev_node_instance_type" {
#   description = "EC2 instance type for the EKS nodes"
#   type        = string
#   default     = "t3.medium"
# }

# variable "eks_dev_node_ami_id" {
#   description = "AMI ID for the EKS nodes"
#   type        = string
#   default     = null # Uses the Amazon EKS optimized AMI by default if not specified
# }

# variable "eks_dev_node_ami_release_version" {
#   description = "AMI release version for the EKS nodes"
#   type        = string
#   default     = null
# }

# # Network configuration
# variable "eks_dev_vpc_id" {
#   description = "ID of the VPC where the EKS cluster will be deployed"
#   type        = string
# }

# variable "eks_dev_subnet_ids" {
#   description = "List of subnet IDs where the EKS cluster will be deployed"
#   type        = list(string)
# }

# variable "eks_dev_public_subnet_ids" {
#   description = "List of public subnet IDs for the EKS cluster"
#   type        = list(string)
# }

# variable "eks_dev_private_subnet_id" {
#   description = "Private subnet ID for the EKS cluster"
#   type        = string
#     default     = "1011.12.13.0/24"
# }

# # Untuk versi perbaikan yang menggunakan private_subnet_ids (jamak)
# variable "eks_dev_private_subnet_ids" {
#   description = "List of private subnet IDs for the EKS cluster"
#   type        = list(string)
#   default     = []
# }

# # Security configuration
# variable "eks_dev_security_group_rules" {
#   description = "Security group rules for the EKS cluster"
#   type        = list(map(string))
#   default     = []
# }

# # Tagging
# variable "project_name" {
#   description = "Name of the project"
#   type        = string
#   default     = "eks-project"
# }
