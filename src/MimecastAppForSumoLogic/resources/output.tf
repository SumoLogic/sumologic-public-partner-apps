output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.mimecast_email_activity.id,
      "name" = sumologic_dashboard.mimecast_email_activity.title,
    },
    {
      "id" = sumologic_dashboard.mimecast_spam_detection.id,
      "name" = sumologic_dashboard.mimecast_spam_detection.title,
    },
    {
      "id" = sumologic_dashboard.mimecast_tls.id,
      "name" = sumologic_dashboard.mimecast_tls.title,
    },
    {
      "id" = sumologic_dashboard.mimecast_ttp_url_protect.id,
      "name" = sumologic_dashboard.mimecast_ttp_url_protect.title,
    },
    {
      "id" = sumologic_dashboard.mimecast_virus_detection.id,
      "name" = sumologic_dashboard.mimecast_virus_detection.title,
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

