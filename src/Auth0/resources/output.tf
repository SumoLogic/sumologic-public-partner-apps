output "dashboards" {
  description = "all the dashboards"
  value       = [
    {
      "id" = sumologic_dashboard.auth___connections_and_clients.id,
      "name" = sumologic_dashboard.auth___connections_and_clients.title,
    },
    {
      "id" = sumologic_dashboard.auth___overview.id,
      "name" = sumologic_dashboard.auth___overview.title,
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
      "id" = sumologic_log_search.client_version_usage.id,
      "name" = sumologic_log_search.client_version_usage.name,
    },
    {
      "id" = sumologic_log_search.connection_types_per_hour.id,
      "name" = sumologic_log_search.connection_types_per_hour.name,
    },
    {
      "id" = sumologic_log_search.guardian_mfa.id,
      "name" = sumologic_log_search.guardian_mfa.name,
    },
    {
      "id" = sumologic_log_search.logins_by_client_and_country.id,
      "name" = sumologic_log_search.logins_by_client_and_country.name,
    },
    {
      "id" = sumologic_log_search.logins_by_client_per_day.id,
      "name" = sumologic_log_search.logins_by_client_per_day.name,
    },
    {
      "id" = sumologic_log_search.logins_geolocation.id,
      "name" = sumologic_log_search.logins_geolocation.name,
    },
    {
      "id" = sumologic_log_search.logins_per_hour.id,
      "name" = sumologic_log_search.logins_per_hour.name,
    },
    {
      "id" = sumologic_log_search.top_10__source_i_ps_by_failed_login.id,
      "name" = sumologic_log_search.top_10__source_i_ps_by_failed_login.name,
    },
    {
      "id" = sumologic_log_search.top_10_clients.id,
      "name" = sumologic_log_search.top_10_clients.name,
    },
    {
      "id" = sumologic_log_search.top_10_operating_systems_by_unique_user.id,
      "name" = sumologic_log_search.top_10_operating_systems_by_unique_user.name,
    },
    {
      "id" = sumologic_log_search.top_10_recent_errors.id,
      "name" = sumologic_log_search.top_10_recent_errors.name,
    },
    {
      "id" = sumologic_log_search.top_10_user_agents.id,
      "name" = sumologic_log_search.top_10_user_agents.name,
    },
    {
      "id" = sumologic_log_search.top_10_users_by_failed_login.id,
      "name" = sumologic_log_search.top_10_users_by_failed_login.name,
    },
    {
      "id" = sumologic_log_search.top_10_users_by_successful_login.id,
      "name" = sumologic_log_search.top_10_users_by_successful_login.name,
    }
  ]
}
