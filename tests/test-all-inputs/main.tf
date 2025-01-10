module "centralized_root_access" {
  source = "../.."

  org_centralized_root_access = {
    organization_features = {
      enabled_features = [
        "RootCredentialsManagement",
        "RootSessions"
      ]
    }

    delegated_administrator = {
      account_id = data.aws_caller_identity.this.account_id
    }
  }
}

# This module requires that the default AWS provider must be configured for the
# AWS Organization account
provider "aws" {
  profile = "awsorg"
}

provider "aws" {
  alias   = "iam_admin"
  profile = "aws"
}

data "aws_caller_identity" "this" {
  provider = aws.iam_admin
}
