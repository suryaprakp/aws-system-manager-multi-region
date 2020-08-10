terraform {
  required_version = ">= 0.12, < 0.13"

  required_providers {
    aws = "~> 2.0"
  }

  backend "s3" {
    bucket               = "mybucket-ssm-terraform-state"
    key                  = "terraform.tfstate"
    region               = "eu-central-1"
    dynamodb_table       = "terraform-ssm-state"
    encrypt              = true
    workspace_key_prefix = "aws-systems-manager"
  }
}

provider "aws" {

  region              = local.default_aws_region
  allowed_account_ids = [var.aws_allowed_account_id]

  # Allow any 2.56.0 version of the AWS provider
  version = "~> 2.56.0"

  # Assume role for prod , This case you dont need to store any credentials for prod
  #assume_role {
  #  role_arn = "arn:aws:iam::905033465232:role/OrganizationAccountAccessRole"
  #  role_arn = "${var.workspace_iam_roles[terraform.workspace]}  "
  #}
}

locals {
  default_aws_region = terraform.workspace == "default" ? "eu-central-1" : terraform.workspace
}
