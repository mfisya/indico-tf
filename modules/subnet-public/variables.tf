variable "vpc_id" {
  description = "The VPC ID where the public subnet will be created"
  type        = string
  default     = "vpc-12345678"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "availability_zones" {
  description = "The availability zones for the public subnet"
  type        = list(string)
}
