

variable "waf_name" {
  description = "Nama Web ACL WAF"
  type        = string
  default     = "my-waf-acl"
}

variable "environment" {
  description = "Lingkungan deployment (misal: dev, prod)"
  type        = string
  default     = "dev"
}

variable "origin_domain" {
  description = "Domain asal untuk CloudFront"
  type        = string
  default     = "example.com.s3.amazonaws.com" # Ganti dengan domain asal Anda
}