variable "cluster_name" {
    description = "The name of the EKS cluster"
    type        = string
}

variable "cluster_version" {
    description = "The version of the EKS cluster"
    type        = string
}

variable "subnet_ids" {
    description = "The IDs of the subnets to use for the EKS cluster"
    type        = list(string)
}

variable "vpc_id" {
    description = "The ID of the VPC to deploy the EKS cluster"
    type        = string
}

variable "desired_capacity" {
    description = "The desired number of nodes in the node group"
    type        = number
}

variable "min_size" {
    description = "The minimum number of nodes in the node group"
    type        = number
}

variable "max_size" {
    description = "The maximum number of nodes in the node group"
    type        = number
}

variable "environment" {
    description = "The environment for the EKS cluster"
    type        = string
}