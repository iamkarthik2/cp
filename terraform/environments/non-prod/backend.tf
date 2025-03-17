terraform {
  backend "s3" {
    bucket         = var.terraform_state_bucket
    key            = var.terraform_state_key
    region         = var.aws_region
    dynamodb_table = var.dynamodb_table
    encrypt        = var.encrypt_state
  }
}
