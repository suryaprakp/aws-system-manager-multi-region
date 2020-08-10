resource "aws_cloudwatch_log_group" "ssm_log_group" {
  name = "${var.resource_prefix}sessions-loggroup"
  #name_prefix       = "${var.resource_prefix}ssm"
  retention_in_days = var.retention_in_days

  # Encrypting cloudwatch logs
  kms_key_id = aws_kms_key.ssm_cloudwatch_key.arn

  tags = merge({
    "Name" = format("${var.resource_prefix}%s", "cloudwatch-group")
  }, var.default_tags)

  depends_on = [aws_kms_alias.ssm_cloudwatch_key_alias]
}

resource "aws_kms_key" "ssm_cloudwatch_key" {
  description         = "KMS key used to encrypt all session manager logs"
  enable_key_rotation = var.enable_key_rotation
  policy              = <<EOF
  {
    "Version": "2012-10-17",
    "Id": "key-default-1",
    "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
          "AWS": "arn:aws:iam::${var.aws_allowed_account_id}:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Principal": {
            "Service": "logs.${var.aws_region}.amazonaws.com"
        },
        "Action": [
            "kms:Encrypt*",
            "kms:Decrypt*",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:Describe*"
        ],
        "Resource": "*"
    }]
  }
  EOF 

  tags = merge({
    "Name" = format("${var.resource_prefix}%s", "kms-key")
  }, var.default_tags)
}

resource "aws_kms_alias" "ssm_cloudwatch_key_alias" {
  name          = "alias/${var.resource_prefix}cloudwatch-key"
  target_key_id = aws_kms_key.ssm_cloudwatch_key.key_id
}
