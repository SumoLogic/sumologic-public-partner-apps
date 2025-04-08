output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.phylum_threat_feed_dashboard.id,
      "name" = sumologic_dashboard.phylum_threat_feed_dashboard.title,
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
      "id" = sumologic_log_search.example_query.id,
      "name" = sumologic_log_search.example_query.name,
    }
  ]
}

