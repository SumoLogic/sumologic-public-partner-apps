output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.application_insights_overview.id,
      "name" = sumologic_dashboard.application_insights_overview.title,
    },
    {
      "id" = sumologic_dashboard.dev_ops_api_inventory_and_network_insights.id,
      "name" = sumologic_dashboard.dev_ops_api_inventory_and_network_insights.title,
    },
    {
      "id" = sumologic_dashboard.hippa_network_compliance_evaluation.id,
      "name" = sumologic_dashboard.hippa_network_compliance_evaluation.title,
    },
    {
      "id" = sumologic_dashboard.hippa_network_compliance_risk_analysis.id,
      "name" = sumologic_dashboard.hippa_network_compliance_risk_analysis.title,
    },
    {
      "id" = sumologic_dashboard.hippa_network_compliance_technology_asset_inventory.id,
      "name" = sumologic_dashboard.hippa_network_compliance_technology_asset_inventory.title,
    },
    {
      "id" = sumologic_dashboard.identifier_analysis_url_analysis.id,
      "name" = sumologic_dashboard.identifier_analysis_url_analysis.title,
    },
    {
      "id" = sumologic_dashboard.m____dns_information.id,
      "name" = sumologic_dashboard.m____dns_information.title,
    },
    {
      "id" = sumologic_dashboard.m____web_traffic_details.id,
      "name" = sumologic_dashboard.m____web_traffic_details.title,
    },
    {
      "id" = sumologic_dashboard.pci_compliance_cardholder_data_protection.id,
      "name" = sumologic_dashboard.pci_compliance_cardholder_data_protection.title,
    },
    {
      "id" = sumologic_dashboard.pci_compliance_secure_data_transmission.id,
      "name" = sumologic_dashboard.pci_compliance_secure_data_transmission.title,
    },
    {
      "id" = sumologic_dashboard.pci_compliance_secure_systems_and_insecure_protocol_insights.id,
      "name" = sumologic_dashboard.pci_compliance_secure_systems_and_insecure_protocol_insights.title,
    },
    {
      "id" = sumologic_dashboard.rogue_activity_cryptojacketing.id,
      "name" = sumologic_dashboard.rogue_activity_cryptojacketing.title,
    },
    {
      "id" = sumologic_dashboard.rogue_activity_unsanctioned_peer_to_peer_apps.id,
      "name" = sumologic_dashboard.rogue_activity_unsanctioned_peer_to_peer_apps.title,
    },
    {
      "id" = sumologic_dashboard.security_posture_ssl_certificate_info.id,
      "name" = sumologic_dashboard.security_posture_ssl_certificate_info.title,
    },
    {
      "id" = sumologic_dashboard.security_posture_ssl_cryptographic_details.id,
      "name" = sumologic_dashboard.security_posture_ssl_cryptographic_details.title,
    },
    {
      "id" = sumologic_dashboard.troubleshooting_insights_for_network_traffic.id,
      "name" = sumologic_dashboard.troubleshooting_insights_for_network_traffic.title,
    },
    {
      "id" = sumologic_dashboard.troubleshooting_top_traffic_source_and_destinations.id,
      "name" = sumologic_dashboard.troubleshooting_top_traffic_source_and_destinations.title,
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

