variable "region" {
  description = "AWS region untuk deployment"
  type        = string
  default     = "us-east-1"
}

variable "firewall_name" {
  description = "Nama firewall"
  type        = string
  default     = "my-network-firewall"
}

variable "environment" {
  description = "Lingkungan deployment (misal: dev, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "ID dari VPC yang sudah ada"
  type        = string
}

variable "subnet_ids" {
  description = "Daftar ID subnet yang sudah ada"
  type        = list(string)
  default     = [1]
}
variable "subnet_id" {
  description = "ID dari subnet yang sudah ada"
  type        = string
  default     = null
}