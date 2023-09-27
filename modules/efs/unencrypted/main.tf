resource "aws_efs_file_system" "main" {
  creation_token   = "efs-unencrypted"
  encrypted        = false
  performance_mode = "generalPurpose"
  throughput_mode  = "elastic"
}

resource "aws_efs_mount_target" "vpc" {
  file_system_id = aws_efs_file_system.main.id
  subnet_id      = var.subnet_id
}
