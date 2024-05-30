output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.cyral_application_activity_details.id,
      "name" = sumologic_dashboard.cyral_application_activity_details.title,
    },
    {
      "id" = sumologic_dashboard.cyral_data_monitoring_activity.id,
      "name" = sumologic_dashboard.cyral_data_monitoring_activity.title,
    },
    {
      "id" = sumologic_dashboard.cyral_policy_summary.id,
      "name" = sumologic_dashboard.cyral_policy_summary.title,
    },
    {
      "id" = sumologic_dashboard.cyral_security_summary.id,
      "name" = sumologic_dashboard.cyral_security_summary.title,
    },
    {
      "id" = sumologic_dashboard.cyral_user_activity_details.id,
      "name" = sumologic_dashboard.cyral_user_activity_details.title,
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

