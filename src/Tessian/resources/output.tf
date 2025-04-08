output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.tessian_architect.id,
      "name" = sumologic_dashboard.tessian_architect.title,
    },
    {
      "id" = sumologic_dashboard.tessian_defender.id,
      "name" = sumologic_dashboard.tessian_defender.title,
    },
    {
      "id" = sumologic_dashboard.tessian_guardian.id,
      "name" = sumologic_dashboard.tessian_guardian.title,
    },
    {
      "id" = sumologic_dashboard.tessian_overview.id,
      "name" = sumologic_dashboard.tessian_overview.title,
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
