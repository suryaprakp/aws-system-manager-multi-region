variable "resource_prefix" {
  description = "Resource prefix added to all the resouces provisioned through this module"
  type        = string
  default     = "default"
}

variable "ssm_document_name" {
  description = "SSM document name "
  type        = string
}

variable "ssm_document_type" {
  description = "SSM document type"
  type        = string
}

variable "ssm_doc_content" {
  description = "SSM document content"
  type        = string
}
