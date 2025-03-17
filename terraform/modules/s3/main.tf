data "aws_iam_policy_document" "s3_rcp_policy" {
  statement {
    effect = "Deny"

    actions = [
      "s3:PutBucketPolicy",
      "s3:PutAccessPointPolicyForObjectLambda",
      "s3:PutAccessPointPolicy",
      "s3:DeleteBucketPolicy",
      "s3:DeleteAccessPointPolicy",
      "s3:DeleteAccessPointPolicyForObjectLambda",
      "s3:PutAccessGrantsInstanceResourcePolicy",
      "s3:DeleteAccessGrantsInstanceResourcePolicy"
    ]
    
    not_resources = var.excluded_buckets

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_organizations_policy" "s3_rcp" {
  name    = var.policy_name
  content = data.aws_iam_policy_document.s3_rcp_policy.minified_json
  type    = "RESOURCE_CONTROL_POLICY"
}