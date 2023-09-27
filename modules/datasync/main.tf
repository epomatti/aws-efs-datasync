resource "aws_datasync_location_efs" "unencrypted" {
  # The below example uses aws_efs_mount_target as a reference to ensure a mount target already exists when resource creation occurs.
  # You can accomplish the same behavior with depends_on or an aws_efs_mount_target data source reference.
  efs_file_system_arn = var.efs_unencrypted_arn

  ec2_config {
    security_group_arns = [var.efs_unencrypted_sg_arn]
    subnet_arn          = var.subnet_arn
  }
}

resource "aws_datasync_location_efs" "encrypted" {
  # The below example uses aws_efs_mount_target as a reference to ensure a mount target already exists when resource creation occurs.
  # You can accomplish the same behavior with depends_on or an aws_efs_mount_target data source reference.
  efs_file_system_arn = var.efs_encrypted_arn

  in_transit_encryption = "TLS1_2"

  ec2_config {
    security_group_arns = [var.efs_encrypted_sg_arn]
    subnet_arn          = var.subnet_arn
  }
}
