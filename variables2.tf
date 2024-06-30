variable "subscription_id" {
  default = ""
}

variable "client_id" {
  default = ""
}

variable "client_secret" {
  #This will force an ask for the client secret

}

variable "tenant_id" {
  default = ""
}

variable "location" {

  default = "eastus"
}
variable "admin_password" {
  default = ""
}
variable "coid" {
  #this is just an example customer code. Must be 4 chars
  default = ""
}

variable "admin_password_init" {
  description = "(Optional) Virtual machine administrator password used during bootstrap (unchanging). This is not needed if ssh_key_value_init is supplied"
  type        = string
  sensitive   = true
  default     = null
}
