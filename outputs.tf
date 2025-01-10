output "iam_organizations_features" {
  description = "Object with attributes of the AWS IAM Organizations features"
  value       = aws_iam_organizations_features.this
}

output "organizations_delegated_administrator" {
  description = "Object with attributes of the AWS Organizations delegated administrator"
  value       = aws_organizations_delegated_administrator.this
}
