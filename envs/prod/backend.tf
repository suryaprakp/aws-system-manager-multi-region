module "terraform_backend" {
  source                 = "../../modules/terraform_backend_v1"
  rmstate_s3_bucket      = "mybucket-prod-ssm-terraform-state"
  rmstate_dynamodb_table = "terraform-ssm-state"
  resource_prefix        = local.resource_prefix
  aws_region             = local.backend_aws_region
  default_tags           = var.default_tags
}

locals {
  backend_aws_region = terraform.workspace == "default" ? "eu-central-1" : terraform.workspace

  backend_resource_prefix = lookup(var.resource_prefix, local.aws_region)
}
