data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  aws_account_id        = data.aws_caller_identity.current.account_id
  aws_region            = data.aws_region.current.name
  aws_account_principal = "arn:aws:iam::${local.aws_account_id}:root"
}

resource "aws_kms_key" "efs" {
  description             = "EFS CMK"
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "efs" {
  name          = "alias/efs"
  target_key_id = aws_kms_key.efs.key_id
}

resource "aws_kms_key_policy" "efs" {
  key_id = aws_kms_key.efs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "EvandroCustomEFS"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "${local.aws_account_principal}"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      # {
      #   Sid    = "Allow attachment of persistent resources"
      #   Effect = "Allow"
      #   Principal = {
      #     AWS = "${var.ec2_iam_role_arn}"
      #   }
      #   Action = [
      #     "kms:*"
      #   ]
      #   Resource = "*"
      # }
    ]
  })
}
