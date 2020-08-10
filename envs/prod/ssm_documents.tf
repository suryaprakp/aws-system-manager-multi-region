module "ssm_documents" {
  source            = "../../modules/ssm_document_v1"
  resource_prefix   = local.resource_prefix_ssm_doc
  ssm_document_name = "loggroup_attach"
  ssm_document_type = "Session"
  ssm_doc_content   = <<DOC
    {
        "schemaVersion": "1.0",
        "description": "Document to hold regional settings for Session Manager",
        "sessionType": "Standard_Stream",
        "inputs": {
            "s3BucketName": "",
            "s3KeyPrefix": "",
            "s3EncryptionEnabled": false,
            "cloudWatchLogGroupName": ${jsonencode(module.ssm_session_logs.cloudwatch_group_name)},
            "cloudWatchEncryptionEnabled": false,
            "kmsKeyId": "",
            "runAsEnabled": false,
            "runAsDefaultUser": ""
        }
    }
DOC
}

locals {
  aws_region_name = terraform.workspace == "default" ? "eu-central-1" : terraform.workspace

  resource_prefix_ssm_doc = lookup(var.resource_prefix, local.aws_region_name)
}
