variable "vpc_hub_cidr" {
  description = "CIDR block for VPC"
  default     = "10.2.0.0/16"
}

variable "vpc_hub_name" {
  description = "Name of the VPC (Production environment)"
  default     = "vpc-hub"
}

variable "vpc_hub_public_subnet_cidr" {
  description = "CIDR block for public subnet"
  default     = "10.2.0.0/16"
}

variable "vpc_hub_availability_zones" {
  description = "List of availability zones"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "vpc_prod_id" {
  description = "VPC ID for the production environment"
  default     = ""
}

variable "vpc_dev_id" {
  description = "VPC ID for the development environment"
  default     = ""
}

variable "vpc_prod_cidr" {
  description = "CIDR block for the production VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_dev_cidr" {
  description = "CIDR block for the development VPC"
  default     = "10.1.0.0/16"
}

variable "rt_vpc_prod_id" {
  description = "Route table ID for the production VPC"
  default     = ""
}

variable "rt_vpc_dev_id" {
  description = "Route table ID for the development VPC"
  default     = ""
}