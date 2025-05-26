variable "integration_root_dir" {
    type        = string
    description = "The folder in which app should be installed."
    default     = ""
}
variable "integration_name" {
  type        = string
  description = "The name of the integration"
  default     = ""
}

variable "integration_description" {
  type        = string
  description = "The description of the integration"
  default     = ""
}

variable "jamf_protect_folder_name" {
  type        = string
  description = "jamf_protect folder name"
  default     = "Jamf Protect"
}

variable "jamf_protect_folder_description" {
  type        = string
  description = "jamf_protect folder description"
  default     = "Events from Jamf Protect"
}

variable "jamf_security_cloud_folder_name" {
  type        = string
  description = "jamf_security_cloud folder name"
  default     = "Jamf Security Cloud"
}

variable "jamf_security_cloud_folder_description" {
  type        = string
  description = "jamf_security_cloud folder description"
  default     = "Events from Jamf Security Cloud"
}

variable "scope_key1" {
  type        = string
  description = "The scope for app queries"
  default     = ""
}

variable "default_scope_value1" {
  type        = string
  description = "The default scope value of scope_key1_variable_display_name variable"
  default     = ""
}

variable "scope_key1_variable_display_name" {
  type        = string
  description = "The display name for scope_key1 scope"
  default     = "Logsdatasource1"
}

variable "scope_key" {
  type        = string
  description = "The scope for app queries"
  default     = ""
}

variable "default_scope_value" {
  type        = string
  description = "The default scope value of scope_key_variable_display_name variable"
  default     = ""
}

variable "scope_key_variable_display_name" {
  type        = string
  description = "The display name for scope_key scope"
  default     = "Logsdatasource"
}

