resource "sumologic_folder" "integration_folder" {
  name        = var.integration_name
  description = var.integration_description
  parent_id   = var.integration_root_dir
}
