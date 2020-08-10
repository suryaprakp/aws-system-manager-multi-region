module "ssm_session_logs" {
  source                 = "../../modules/session_log_cloudwatch_v1"
  resource_prefix        = var.resource_prefix
  aws_region             = local.aws_region
  aws_allowed_account_id = var.aws_allowed_account_id
  default_tags           = var.default_tags
  retention_in_days      = 90
  enable_key_rotation    = true
}

locals {
  aws_region = terraform.workspace == "default" ? "eu-central-1" : terraform.workspace
}
