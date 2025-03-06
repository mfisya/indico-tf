variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/22"
}

variable "vpc_name" {
  description = "hub vpc"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "main"
}
