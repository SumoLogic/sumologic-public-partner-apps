resource "sumologic_folder" "integration_folder" {
  name        = var.integration_name
  description = var.integration_description
  parent_id   = var.integration_root_dir
}

resource "sumologic_folder" "jamf_protect_folder" {
  name        = var.jamf_protect_folder_name
  description = var.jamf_protect_folder_description
  parent_id   = sumologic_folder.integration_folder.id
}

resource "sumologic_folder" "jamf_security_cloud_folder" {
  name        = var.jamf_security_cloud_folder_name
  description = var.jamf_security_cloud_folder_description
  parent_id   = sumologic_folder.integration_folder.id
}

