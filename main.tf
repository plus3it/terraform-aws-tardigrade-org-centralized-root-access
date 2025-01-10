resource "aws_organizations_organization" "this" {
  count = var.org_centralized_root_access.create_service_principal != null ? 1 : 0

  aws_service_access_principals = ["iam.amazonaws.com"]
}

resource "aws_iam_organizations_features" "this" {
  enabled_features = [
    "RootCredentialsManagement",
    "RootSessions"
  ]
}

resource "aws_organizations_delegated_administrator" "this" {
  count = var.org_centralized_root_access.delegated_administrator != null ? 1 : 0

  account_id        = var.org_centralized_root_access.delegated_administrator.account_id
  service_principal = "iam.amazonaws.com"
}
