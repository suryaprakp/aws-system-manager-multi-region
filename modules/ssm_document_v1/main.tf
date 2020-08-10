resource "aws_ssm_document" "ssm_document" {
  name          = format("${var.resource_prefix}%s", "${var.ssm_document_name}")
  document_type = var.ssm_document_type

  # The JSON or YAML content of the document
  content = var.ssm_doc_content
}
