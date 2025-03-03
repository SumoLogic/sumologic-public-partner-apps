output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.catchpoint_overview.id,
      "name" = sumologic_dashboard.catchpoint_overview.title,
    },
    {
      "id" = sumologic_dashboard.catchpoint_recent_errors.id,
      "name" = sumologic_dashboard.catchpoint_recent_errors.title,
    },
    {
      "id" = sumologic_dashboard.catchpoint_response_size.id,
      "name" = sumologic_dashboard.catchpoint_response_size.title,
    },
    {
      "id" = sumologic_dashboard.catchpoint_test_times.id,
      "name" = sumologic_dashboard.catchpoint_test_times.title,
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
