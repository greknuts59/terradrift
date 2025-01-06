# Project variables
variable "location" {
  type = string
  description = "The location for the deployment"
}

variable "rsgname" {
  type = string
  description = "Resouce Group name"
}

variable "tenant_id" {
  type = string
  description = "Tenant ID"
}
variable "client_id" {
  type = string
  description = "Client ID"
}
variable "client_secret" {
  type = string
  description = "Client Secret"
}
variable "subscription_id" {
  type = string
  description = "Subscription ID"
}
