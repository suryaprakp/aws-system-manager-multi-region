variable "resource_prefix" {
  description = "Resource prefix added to all the resouces provisioned through this module"
  type        = string
  default     = "default"
}

variable "default_tags" {
  description = "Default tags added to all the resouces"
  type        = map(string)
}
