provider "aws" {
  region = var.region
}

# Membuat Firewall Policy
resource "aws_networkfirewall_firewall_policy" "firewall_policy" {
  name = "${var.firewall_name}-policy"

  firewall_policy {
    stateless_default_actions = ["aws:pass"]
    stateless_fragment_default_actions = ["aws:drop"]

    stateless_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.stateless_rule.arn
      priority     = 1
    }

    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.stateful_rule.arn
    }
  }
}

# Membuat Stateless Rule Group
resource "aws_networkfirewall_rule_group" "stateless_rule" {
  capacity = 100
  name     = "${var.firewall_name}-stateless-rule"
  type     = "STATELESS"
  rule_group {
    rules_source {
      stateless_rules_and_custom_actions {
        stateless_rule {
          priority = 1
          rule_definition {
            actions = ["aws:pass"]
            match_attributes {
              source {
                address_definition = "0.0.0.0/0"
              }
              destination {
                address_definition = "0.0.0.0/0"
              }
              protocols = [6] # TCP
              source_port {
                from_port = 0
                to_port   = 0
              }
              destination_port {
                from_port = 443
                to_port   = 443
              }
            }
          }
        }
      }
    }
  }
}

# Membuat Stateful Rule Group
resource "aws_networkfirewall_rule_group" "stateful_rule" {
  capacity = 100
  name     = "${var.firewall_name}-stateful-rule"
  type     = "STATEFUL"
  rule_group {
    rules_source {
      rules_string = <<EOF
pass tcp any any 443 -s
drop all
EOF
    }
  }
}

# Membuat Firewall (Asumsi subnet dan VPC sudah ada)
resource "aws_networkfirewall_firewall" "firewall" {
  name                = var.firewall_name
  firewall_policy_arn = aws_networkfirewall_firewall_policy.firewall_policy.arn
  vpc_id              = var.vpc_id # Anda perlu menyediakan VPC ID

  # Menggunakan blok subnet_mapping dengan list subnet
  dynamic "subnet_mapping" {
    for_each = var.subnet_ids # Menggunakan daftar subnet dari variabel
    content {
      subnet_id = subnet_mapping.value
    }
  }

  tags = {
    Environment = var.environment
  }
}

  

# Membuat Log Group untuk CloudWatch
resource "aws_cloudwatch_log_group" "firewall_logs" {
  name = "/aws/network-firewall/${var.firewall_name}"
  retention_in_days = 30

  tags = {
    Environment = var.environment
  }
}

# Mengonfigurasi Logging ke CloudWatch dan S3
resource "aws_networkfirewall_logging_configuration" "firewall_logging" {
  firewall_arn = aws_networkfirewall_firewall.firewall.arn
  logging_configuration {
    log_destination_config {
      log_destination_type = "CloudWatchLogs"
      log_destination      = aws_cloudwatch_log_group.firewall_logs.arn
      log_type             = "ALERT"
    }
    log_destination_config {
      log_destination_type = "S3"
      log_destination      = aws_s3_bucket.firewall_logs.arn
      log_type             = "FLOW"
    }
  }
}

# Membuat bucket S3 untuk log firewall
resource "aws_s3_bucket" "firewall_logs" {
  bucket_prefix = "firewall-logs"

  tags = {
    Environment = var.environment
  }
}

