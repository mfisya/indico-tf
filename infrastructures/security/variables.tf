variable "waf_name" {
  description = "Nama Web ACL WAF"
  type        = string
  default     = "my-waf-acl"
}

variable "environment" {
  description = "Lingkungan deployment (misal: dev, prod)"
  type        = string
  default     = "prod"
}

variable "origin_domain" {  
  description = "Domain asal untuk CloudFront"
  type        = string
  default     = "api.indico.com" 
}

variable "firewall_name" {
  description = "Nama firewall"
  type        = string
  default     = "my-network-firewall"
}

variable "vpc_id" {
  description = "ID dari VPC yang sudah ada"
  type        = string
  default     = null
  
}

variable "subnet_id" {
  description = "ID dari subnet yang sudah ada"
  type        = string
  default     = "192.33.1.1/24"
}