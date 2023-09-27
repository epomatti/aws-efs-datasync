resource "aws_ssm_parameter" "efs_unencrypted" {
  name  = "/efs/unencrypted/dnsname"
  type  = "String"
  value = var.efs_unencrypted_dns_name
}

resource "aws_ssm_parameter" "efs_encrypted" {
  name  = "/efs/encrypted/dnsname"
  type  = "String"
  value = var.efs_encrypted_dns_name
}
