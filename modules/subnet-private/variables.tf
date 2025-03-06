variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
  default     = "vpc-12345678"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
}

variable "private_availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}
