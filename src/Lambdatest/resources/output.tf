output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.lambda_test_test_error_overview.id,
      "name" = sumologic_dashboard.lambda_test_test_error_overview.title,
    },
    {
      "id" = sumologic_dashboard.lambda_test_test_overview.id,
      "name" = sumologic_dashboard.lambda_test_test_overview.title,
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

