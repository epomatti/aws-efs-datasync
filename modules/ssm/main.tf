locals {
  prefix = "/efs"
}

resource "aws_ssm_parameter" "efs_unencrypted" {
  name  = "${local.prefix}/unencrypted/dnsname"
  type  = "String"
  value = var.efs_unencrypted_dns_name
}

resource "aws_ssm_parameter" "efs_encrypted" {
  name  = "${local.prefix}/encrypted/dnsname"
  value = var.efs_encrypted_dns_name
}
