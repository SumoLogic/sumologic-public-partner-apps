output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.net_flow_flows_allowed_and_rejected.id,
      "name" = sumologic_dashboard.net_flow_flows_allowed_and_rejected.title,
    },
    {
      "id" = sumologic_dashboard.net_flow_security_monitoring_communications_with_malicious_hosts.id,
      "name" = sumologic_dashboard.net_flow_security_monitoring_communications_with_malicious_hosts.title,
    },
    {
      "id" = sumologic_dashboard.net_flow_security_monitoring_traffic_using_critical_ports.id,
      "name" = sumologic_dashboard.net_flow_security_monitoring_traffic_using_critical_ports.title,
    },
    {
      "id" = sumologic_dashboard.net_flow_traffic_overview.id,
      "name" = sumologic_dashboard.net_flow_traffic_overview.title,
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
