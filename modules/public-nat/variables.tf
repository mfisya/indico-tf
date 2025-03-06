 variable "vpc_id" {
   description = "The VPC ID where the NAT Gateway will be created"
   type        = string
 }

variable "public_subnet_id" {
  description = "The public subnet ID where the NAT Gateway will be created"
  type        = string
  default     = "10.3.0.0/24"
}
