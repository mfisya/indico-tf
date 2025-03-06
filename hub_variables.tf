variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_hub_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_hub_name" {
  description = "Name of the VPC (Production environment)"
  default     = "vpc-hub" # Diubah dari 
}

variable "vpc_hub_public_subnet_cidr" {
  description = "CIDR block for public subnet"
  default     = "10.0.1.0/24"
}

variable "vpc_hub_availability_zones" {
  description = "List of availability zones"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "vpc_hub_private_subnet_cidr" {
  description = "CIDR block for private subnet"
  default     = "10.0.2.0/24"
}

variable "vpc_hub_db_subnet_cidr" {
  description = "CIDR block for database subnet"
  default     = ""
} 

# variable "subnet_private_prod_cidr" {
#   description = "CIDR block for private subnet"
#   default     = "10.1.1.0/24"
  
# }

