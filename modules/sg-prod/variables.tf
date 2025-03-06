variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "allowed_ssh_cidr_blocks" {
  description = "List of CIDR blocks allowed to access via SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
