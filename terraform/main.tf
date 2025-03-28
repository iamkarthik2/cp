terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.88"
    }
  }
  # Optional: Configure remote state backend (update with your bucket details)
  backend "s3" {
    bucket         = "terraformstatemasterbucketforrcp"
    key            = "rcp/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
} 

provider "aws" {
  region = "ap-southeast-2"
}

#resource "aws_organizations_organization" "org" {
#  feature_set          = "ALL"
#  enabled_policy_types = [
#    "RESOURCE_CONTROL_POLICY"
#  ]
# }

data "aws_iam_policy_document" "rcp1" {
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
    not_resources = [ 
      "arn:aws:s3:::origin-as-test-bucket,
      "arn:aws:s3:::origin-as-test-bucket/*,
      "arn:aws:s3:::origin-ssnp-bootstrap",
      "arn:aws:s3:::origin-ssnp-bootstrap/*"
      ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

  }
}

resource "aws_organizations_policy" "rcp1" {
  name    = "rcp1"
  content = data.aws_iam_policy_document.rcp1.minified_json
  type    = "RESOURCE_CONTROL_POLICY"
}

# resource "aws_organizations_organizational_unit" "testapp" {
#   name      = "origin-test-apps"
#   parent_id = aws_organizations_organization.org.roots[0].id
# }

# resource "aws_organizations_organizational_unit" "testusers" {
#   name      = "origin-test-users"
#   parent_id = aws_organizations_organization.org.roots[0].id
# }

# resource "aws_organizations_policy_attachment" "rcp1_testapp" {
#   policy_id = aws_organizations_policy.rcp1.id
#   target_id = aws_organizations_organizational_unit.testapp.id
# }

# resource "aws_organizations_policy_attachment" "rcp1_testusers" {
#   policy_id = aws_organizations_policy.rcp1.id
#   target_id = aws_organizations_organizational_unit.testusers.id
# }
