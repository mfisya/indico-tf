# variable "cluster_name" {
#   description = "The name of the EKS cluster"
#   type        = string
# }

# variable "cluster_version" {
#   description = "The version of the EKS cluster"
#   type        = string
# }

# variable "cluster_role_arn" {
#   description = "The ARN of the IAM role to use for the EKS cluster"
#   type        = string
# }

# variable "node_group_name" {
#   description = "The name of the EKS node group"
#   type        = string
# }

# variable "node_role_arn" {
#   description = "The ARN of the IAM role to use for the EKS nodes"
#   type        = string
# }

# variable "subnet_ids" {
#   description = "The IDs of the subnets to use for the EKS cluster"
#   type        = list(string)
# }

# variable "node_group_size" {
#   description = "The desired size of the EKS node group"
#   type        = number
# }

# variable "node_instance_type" {
#   description = "The instance type for the EKS nodes"
#   type        = string
# }

# variable "node_ami_id" {
#   description = "The AMI ID for the EKS nodes"
#   type        = string
#   default     = ""
# }

# variable "vpc_id" {
#   description = "The ID of the VPC to deploy the EKS cluster"
#   type        = string
# }

# variable "public_subnet_ids" {
#   description = "The IDs of the public subnets to use for the EKS cluster"
#   type        = list(string)
# }

# variable "node_ami_release_version" {
#   description = "The release version of the AMI for the EKS nodes"
#   type        = string
#   default     = "1.18"
# }

# variable "private_subnet_id" {
#   description = "The ID of the private subnet to use for the EKS cluster"
#   type        = string
#   default     = "10.20.1.0/24"
# }
