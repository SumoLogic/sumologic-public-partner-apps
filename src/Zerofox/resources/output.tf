output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.zero_fox_cloud_dashboard.id,
      "name" = sumologic_dashboard.zero_fox_cloud_dashboard.title,
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
      "id" = sumologic_log_search.alerts_by_entity.id,
      "name" = sumologic_log_search.alerts_by_entity.name,
    },
    {
      "id" = sumologic_log_search.alerts_by_network.id,
      "name" = sumologic_log_search.alerts_by_network.name,
    },
    {
      "id" = sumologic_log_search.alerts_by_status.id,
      "name" = sumologic_log_search.alerts_by_status.name,
    },
    {
      "id" = sumologic_log_search.alerts_by_takedown_status.id,
      "name" = sumologic_log_search.alerts_by_takedown_status.name,
    },
    {
      "id" = sumologic_log_search.alerts_by_top_rules.id,
      "name" = sumologic_log_search.alerts_by_top_rules.name,
    },
    {
      "id" = sumologic_log_search.escalated_alerts.id,
      "name" = sumologic_log_search.escalated_alerts.name,
    },
    {
      "id" = sumologic_log_search.successful_takedowns.id,
      "name" = sumologic_log_search.successful_takedowns.name,
    },
    {
      "id" = sumologic_log_search.total_alerts.id,
      "name" = sumologic_log_search.total_alerts.name,
    },
    {
      "id" = sumologic_log_search.total_alerts_by_network.id,
      "name" = sumologic_log_search.total_alerts_by_network.name,
    }
  ]
}

