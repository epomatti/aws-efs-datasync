### EFS ###

resource "aws_efs_file_system" "main" {
  creation_token   = "efs-unencrypted"
  performance_mode = "generalPurpose"
  throughput_mode  = "elastic"

  encrypted = false
}

resource "aws_efs_mount_target" "vpc" {
  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.efs.id]
}


### Security Group ###

data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_security_group" "efs" {
  name   = "efs-sg-unencrypted"
  vpc_id = var.vpc_id

  tags = {
    Name = "sg-efs-unencryped"
  }
}

resource "aws_security_group_rule" "nfs" {
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.selected.cidr_block]
  security_group_id = aws_security_group.efs.id
}
