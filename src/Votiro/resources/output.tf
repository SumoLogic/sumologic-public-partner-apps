output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.votiro_overview.id,
      "name" = sumologic_dashboard.votiro_overview.title,
    }
  ]
}

output "folders" {
  description = "all the folders"
  value       = [
    {
      "id" = sumologic_folder.integration_folder.id,
      "name" = sumologic_folder.integration_folder.name,
    }
  ]
}
