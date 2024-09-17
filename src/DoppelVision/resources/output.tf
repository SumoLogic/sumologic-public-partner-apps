output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.doppel_vision_dashboard.id,
      "name" = sumologic_dashboard.doppel_vision_dashboard.title,
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

output "log_searches" {
  description = "all the log_searches"
  value       = [
    {
      "id" = sumologic_log_search.alerts_by_product.id,
      "name" = sumologic_log_search.alerts_by_product.name,
    },
    {
      "id" = sumologic_log_search.alerts_by_status.id,
      "name" = sumologic_log_search.alerts_by_status.name,
    },
    {
      "id" = sumologic_log_search.resolved_alerts.id,
      "name" = sumologic_log_search.resolved_alerts.name,
    },
    {
      "id" = sumologic_log_search.top_10_alerts_by_product.id,
      "name" = sumologic_log_search.top_10_alerts_by_product.name,
    },
    {
      "id" = sumologic_log_search.total_alerts.id,
      "name" = sumologic_log_search.total_alerts.name,
    },
    {
      "id" = sumologic_log_search.verified_alerts.id,
      "name" = sumologic_log_search.verified_alerts.name,
    }
  ]
}

