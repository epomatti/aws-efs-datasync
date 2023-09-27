output "dns_name" {
  value = aws_efs_file_system.main.dns_name
}

output "efs_arn" {
  value = aws_efs_file_system.main.arn
}

output "sg_arn" {
  value = aws_security_group.efs.arn
}
