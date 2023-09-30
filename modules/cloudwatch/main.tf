resource "aws_cloudwatch_log_group" "datasync" {
  name = "datasync-efs"
}

data "aws_iam_policy_document" "datasync" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]

    resources = ["arn:aws:logs:*"]

    principals {
      identifiers = ["datasync.amazonaws.com"]
      type        = "Service"
    }
  }
}
