terraform {
  backend "s3" {
    bucket = "<bucket_name>"
    workspace_key_prefix = "project01"
    key    = "project01/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform_lock"
  }
}
