variable "org_centralized_root_access" {
  description = "Object containing configuration details to manage centralized root access for the AWS Organization"
  type = object({
    organization_features = optional(object({
      enabled_features = optional(list(string), ["RootCredentialsManagement", "RootSessions"])
    }), {})

    delegated_administrator = optional(object({
      account_id = string
    }))
  })
  nullable = false
  default  = {}
}
