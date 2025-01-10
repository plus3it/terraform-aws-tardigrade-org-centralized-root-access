module "centralized_root_access" {
  source = "../.."
}

# This module requires that the default AWS provider must be configured for the
# AWS Organization account
provider "aws" {
  profile = "awsorg"
}
