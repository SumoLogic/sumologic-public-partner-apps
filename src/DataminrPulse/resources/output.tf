output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.dataminr_alerts_drilldown.id,
      "name" = sumologic_dashboard.dataminr_alerts_drilldown.title,
    },
    {
      "id" = sumologic_dashboard.dataminr_alerts_overview.id,
      "name" = sumologic_dashboard.dataminr_alerts_overview.title,
    },
    {
      "id" = sumologic_dashboard.dataminr_cyber_threat_landscape.id,
      "name" = sumologic_dashboard.dataminr_cyber_threat_landscape.title,
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

