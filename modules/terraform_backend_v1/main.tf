resource "aws_s3_bucket" "rmstate_folder" {
  bucket = var.rmstate_s3_bucket
  count  = var.aws_region == "eu-central-1" ? 1 : 0

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  # Enable versioning by default
  versioning {
    enabled = true
  }
  # bucket level as this repo is using already exisitng bucket 
  tags = merge({
    "Name" = format("${var.resource_prefix}%s", "rmstate-s3-bucket-object")
  }, var.default_tags)
}

resource "aws_dynamodb_table" "terraform_statelock" {
  count          = var.aws_region == "eu-central-1" ? 1 : 0
  name           = var.rmstate_dynamodb_table
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge({
    "Name" = format("${var.resource_prefix}%s", "rmstate-dynamodb-table")
  }, var.default_tags)
}
