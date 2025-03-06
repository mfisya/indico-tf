# filepath: /home/pine/aws/tf-indico/security.tf
# waf, firewall

module "aws_wafv2_web_acl" {
  source = "./modules/waf"
  
  region       = var.region
  waf_name     = var.waf_name
  environment  = var.environment
  origin_domain = var.origin_domain
}

