output "efs_unencrypted_dns_name" {
  value = module.efs_unencrypted.dns_name
}

output "efs_encrypted_kms_dns_name" {
  value = module.efs_encrypted_kms.dns_name
}
