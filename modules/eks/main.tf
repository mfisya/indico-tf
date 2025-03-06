resource "aws_security_group" "eks_cluster_sg" {
    name        = "${var.cluster_name}-eks-cluster-sg"
    description = "Security group for EKS cluster"
    vpc_id      = var.vpc_id

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "eks_node_sg" {
    name        = "${var.cluster_name}-eks-node-sg"
    description = "Security group for EKS nodes"
    vpc_id      = var.vpc_id

    ingress {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 20.0"

    cluster_name    = var.cluster_name
    cluster_version = var.cluster_version

    bootstrap_self_managed_addons = false
    cluster_addons = {
        coredns                = {}
        eks-pod-identity-agent = {}
        kube-proxy             = {}
        vpc-cni                = {}
    }

    # Optional
    cluster_endpoint_public_access = true

    # Optional: Adds the current caller identity as an administrator via cluster access entry
    enable_cluster_creator_admin_permissions = true

    vpc_id                   = var.vpc_id
    subnet_ids               = var.subnet_ids
    control_plane_subnet_ids = var.subnet_ids

    # EKS Managed Node Group(s)
    eks_managed_node_group_defaults = {
        instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
    }

    eks_managed_node_groups = {
        example = {
            # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
            ami_type       = "AL2023_x86_64_STANDARD"
            instance_types = ["m5.xlarge"]

            min_size     = var.min_size
            max_size     = var.max_size
            desired_size = var.desired_capacity
        }
    }

    tags = {
        Environment = var.environment
        Terraform   = "true"
    }
}