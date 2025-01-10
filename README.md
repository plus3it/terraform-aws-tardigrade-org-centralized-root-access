# terraform-aws-tardigrade-org-centralized-root-access

Terraform module to manage centralized root access for an AWS Organization.

To configure centralized root access for an AWS Organization, the Organization
must enable service access for the IAM principal, `iam.amazonaws.com`. Currently,
the Terraform AWS Provider does not have a resource that *only* enables service
access for an Organization. Therefore, it is up to the user to coordinate the enablement
of IAM service access before using this module.

> NOTE: There is the resource `aws_organizations_organization`, which *can* enable
> service access. However, it expects *exclusive* control over all enabled services
> and features and other attributes of the resource. It cannot be used to enable
> *just* a single service, i.e. `iam.amazonaws.com`, while ignoring any other enabled
> or disabled service. Anything it is not configured to enable, it will disable!
> It is not appropriate to use this resource in a module like this one that is
> designed to manage a single Organization feature.

To determine if IAM service access is enabled for the Organization, run this command
using a credential for the AWS Organization account:

```bash
aws organizations list-aws-service-access-for-organization --query 'EnabledServicePrincipals[? ServicePrincipal == `iam.amazonaws.com`]'
```

If enabled, it will return something like:

```bash
[
    {
        "ServicePrincipal": "iam.amazonaws.com",
        "DateEnabled": "2025-01-10T14:30:07.609000-08:00"
    }
]
```

If not enabled, it will simply return an empty list:

```bash
[]
```

To enable IAM service access for the AWS Organization, run this command:

```bash
aws organizations enable-aws-service-access --service-principal iam.amazonaws.com
```

<!-- BEGIN TFDOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_org_centralized_root_access"></a> [org\_centralized\_root\_access](#input\_org\_centralized\_root\_access) | Object containing configuration details to manage centralized root access for the AWS Organization | <pre>object({<br/>    organization_features = optional(object({<br/>      enabled_features = optional(list(string), ["RootCredentialsManagement", "RootSessions"])<br/>    }), {})<br/><br/>    delegated_administrator = optional(object({<br/>      account_id = string<br/>    }))<br/>  })</pre> | `{}` | no |

## Outputs

No outputs.

<!-- END TFDOCS -->
