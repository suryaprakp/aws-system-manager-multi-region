variable "aws_region" {
  description = "Region in which resources are provisioned"
  type        = string
  default     = "eu-central-1"
}

variable "aws_allowed_account_id" {
  description = "Restrict which AWS account it can use this terraform deployemnt"
  type        = string
}

variable "resource_prefix" {
  description = "Resource prefix added to all the resouces provisioned through this module"
  type        = string
  default     = "default"
}

variable "retention_in_days" {
  description = " "
  type        = number
  default     = 90
}

variable "enable_key_rotation" {
  description = " Enable key rotation for KMS"
  type        = bool
  default     = false
}

variable "default_tags" {
  description = "Default tags added to all the resouces"
  type        = map(string)
}
