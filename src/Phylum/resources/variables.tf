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

variable "lookup_table_path" {
  type        = string
  description = "Enter user-created Phylum threat data lookup table path"
  default     = ""
}
