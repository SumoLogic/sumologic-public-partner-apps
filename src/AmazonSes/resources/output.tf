output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.amazon_ses_bounced_notifications.id,
      "name" = sumologic_dashboard.amazon_ses_bounced_notifications.title,
    },
    {
      "id" = sumologic_dashboard.amazon_ses_cloud_trail_events_by_event_name.id,
      "name" = sumologic_dashboard.amazon_ses_cloud_trail_events_by_event_name.title,
    },
    {
      "id" = sumologic_dashboard.amazon_ses_cloud_trail_events_overview.id,
      "name" = sumologic_dashboard.amazon_ses_cloud_trail_events_overview.title,
    },
    {
      "id" = sumologic_dashboard.amazon_ses_complaint_notifications.id,
      "name" = sumologic_dashboard.amazon_ses_complaint_notifications.title,
    },
    {
      "id" = sumologic_dashboard.amazon_ses_delivered_notifications.id,
      "name" = sumologic_dashboard.amazon_ses_delivered_notifications.title,
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

