resource "aws_iam_organizations_features" "this" {
  enabled_features = [
    "RootCredentialsManagement",
    "RootSessions"
  ]

  lifecycle {
    precondition {
      condition     = data.aws_organizations_organization.this.master_account_id == data.aws_caller_identity.this.account_id
      error_message = "The AWS Organization account must be used to enable the AWS Organizations features. Please run this module with a provider configured for the AWS Organization account."
    }
  }
}

resource "aws_organizations_delegated_administrator" "this" {
  count = var.org_centralized_root_access.delegated_administrator != null ? 1 : 0

  account_id        = var.org_centralized_root_access.delegated_administrator.account_id
  service_principal = "iam.amazonaws.com"
}

data "aws_organizations_organization" "this" {}
data "aws_caller_identity" "this" {}
