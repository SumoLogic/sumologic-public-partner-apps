output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.cisco_asa.id,
      "name" = sumologic_dashboard.cisco_asa.title,
    },
    {
      "id" = sumologic_dashboard.cisco_firepower.id,
      "name" = sumologic_dashboard.cisco_firepower.title,
    },
    {
      "id" = sumologic_dashboard.palo_alto_networks.id,
      "name" = sumologic_dashboard.palo_alto_networks.title,
    },
    {
      "id" = sumologic_dashboard.suricata.id,
      "name" = sumologic_dashboard.suricata.title,
    },
    {
      "id" = sumologic_dashboard.zeek.id,
      "name" = sumologic_dashboard.zeek.title,
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

