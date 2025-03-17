variable "policy_name" {
  description = "Name of the S3 RCP policy"
  type        = string
}

variable "excluded_buckets" {
  description = "List of bucket ARNs to exclude from the policy"
  type        = list(string)
}
