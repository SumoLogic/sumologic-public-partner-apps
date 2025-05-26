output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.jamf_protect_alerts_overview.id,
      "name" = sumologic_dashboard.jamf_protect_alerts_overview.title,
    },
    {
      "id" = sumologic_dashboard.jamf_protect_telemetry_overview.id,
      "name" = sumologic_dashboard.jamf_protect_telemetry_overview.title,
    },
    {
      "id" = sumologic_dashboard.jamf_security_cloud_threat_stream.id,
      "name" = sumologic_dashboard.jamf_security_cloud_threat_stream.title,
    }
  ]
}

output "folders" {
  description = "all the folders"
  value       = [
    {
      "id" = sumologic_folder.integration_folder.id,
      "name" = sumologic_folder.integration_folder.name,
    },
    {
      "id" = sumologic_folder.jamf_protect_folder.id,
      "name" = sumologic_folder.jamf_protect_folder.name,
    },
    {
      "id" = sumologic_folder.jamf_security_cloud_folder.id,
      "name" = sumologic_folder.jamf_security_cloud_folder.name,
    }
  ]
}

