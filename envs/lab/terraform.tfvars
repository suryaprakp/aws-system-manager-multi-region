environment = "ftest2"
product     = "infra"
service     = "ssm"

resource_prefix        = "mybucket-lab-ssm-infra-"
aws_allowed_account_id = "098456509636"

default_tags = {
  Environment = "ftest"
  Service     = "ssm"
  Product     = "infra"
  Terraform   = true
}
