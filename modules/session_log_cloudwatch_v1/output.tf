output "cloudwatch_group_arn" {
  value = aws_cloudwatch_log_group.ssm_log_group.arn
}

output "cloudwatch_group_name" {
  value = aws_cloudwatch_log_group.ssm_log_group.name
}

output "cloudwatch_logs_kms_alias" {
  value = aws_kms_alias.ssm_cloudwatch_key_alias.arn
}

