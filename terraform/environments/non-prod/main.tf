module "s3" {
  source        = "../../modules/s3"
  policy_name   = "s3-rcp-nonprod"
  excluded_buckets = [
    "arn:aws:s3:::origin-as-test-bucket",
    "arn:aws:s3:::origin-as-test-bucket/*",
    "arn:aws:s3:::origin-ssnp-bootstrap",
    "arn:aws:s3:::origin-ssnp-bootstrap/*"
  ]
}
