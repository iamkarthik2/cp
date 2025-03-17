variable "aws_region" {
  description = "The AWS region where resources will be deployed"
  type        = string
  default     = "ap-southeast-2"
}

variable "terraform_state_bucket" {
  description = "S3 bucket for storing Terraform state"
  type        = string
  default     = "terraformstatemasterbucketforrcpnp"
}

variable "terraform_state_key" {
  description = "Path for Terraform state file in S3"
  type        = string
  default     = "rcp/nonprod/terraform.tfstate"
}

variable "dynamodb_table" {
  description = "DynamoDB table for Terraform state locking"
  type        = string
  default     = "terraform-lock-table"
}

variable "encrypt_state" {
  description = "Encrypt Terraform state in S3"
  type        = bool
  default     = true
}
