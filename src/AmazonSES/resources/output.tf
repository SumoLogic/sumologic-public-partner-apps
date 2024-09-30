output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.amazon_ses_cloud_trail_evens_overeview.id,
      "name" = sumologic_dashboard.amazon_ses_cloud_trail_evens_overeview.title,
    },
    {
      "id" = sumologic_dashboard.amazon_ses_complaint_notifications.id,
      "name" = sumologic_dashboard.amazon_ses_complaint_notifications.title,
    },
    {
      "id" = sumologic_dashboard.amazon_ses_notification_overview.id,
      "name" = sumologic_dashboard.amazon_ses_notification_overview.title,
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

