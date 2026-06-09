resource "sumologic_monitor" "auth_0__events_from_embargoed_locations" {
  content_type        = "Monitor"
  description         = "Alerts on logins or actions from embargoed locations, suggesting potential unauthorized access. Investigate to confirm legitimacy or block malicious actors."
  evaluation_delay    = "0m"
  group_notifications = "true"
  monitor_type        = "Logs"
  name                = "Auth0 - Events from Embargoed Locations"


  queries {
    query  = "${var.scope_key}=${var.default_scope_value}  ip\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"ip\" as type, user_name, client_name, ip nodrop\n\n| where !isBlank(ip)\n| count by log_id, type, user_name, client_name, ip\n| lookup latitude, longitude, country_code, country_name, state, city from geo://location on ip = ip\n| where !isNull(latitude)\n| lookup country_code from https://sumologic-app-data.s3.amazonaws.com/riskycountries.csv on country_code=country_code \n| where !isNull(country_code)\n| count by ip, country_code, country_name, state, city, type, user_name, client_name"
    row_id = "A"
  }


  triggers {
    detection_method  = "LogsStaticCondition"
    min_data_points   = "1"
    resolution_window = "15m"
    threshold         = "0"
    threshold_type    = "LessThanOrEqual"
    time_range        = "15m"
    trigger_type      = "ResolvedCritical"
  }

  triggers {
    detection_method = "LogsStaticCondition"
    min_data_points  = "1"
    threshold        = "0"
    threshold_type   = "GreaterThan"
    time_range       = "15m"
    trigger_type     = "Critical"
  }

}

resource "sumologic_monitor" "auth_0__multiple_failed_authentication_from_single_user" {
  content_type        = "Monitor"
  description         = "Monitors and highlights multiple failed authentications from single user in short period of time"
  evaluation_delay    = "0m"
  group_notifications = "true"
  monitor_type        = "Logs"
  name                = "Auth0 - Multiple Failed Authentication From Single User"


  queries {
    query  = "${var.scope_key}=${var.default_scope_value}  log_id user_name (\"fp\" OR \"fu\")\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// panel specific\n| where type in (\"fp\", \"fu\") and !isBlank(user_name)\n| count by log_id, user_name, type, ip, client_name \n| count by user_name, type, ip, client_name \n| fields - _count"
    row_id = "A"
  }


  triggers {
    detection_method  = "LogsStaticCondition"
    min_data_points   = "1"
    resolution_window = "15m"
    threshold         = "3"
    threshold_type    = "LessThanOrEqual"
    time_range        = "15m"
    trigger_type      = "ResolvedCritical"
  }

  triggers {
    detection_method = "LogsStaticCondition"
    min_data_points  = "1"
    threshold        = "3"
    threshold_type   = "GreaterThan"
    time_range       = "15m"
    trigger_type     = "Critical"
  }

}

resource "sumologic_monitor" "auth_0__untrusted_ip_detected" {
  content_type        = "Monitor"
  description         = "Monitors and highlights untrusted detected IP which are in the deny list"
  evaluation_delay    = "0m"
  group_notifications = "true"
  monitor_type        = "Logs"
  name                = "Auth0 - Untrusted IP Detected"


  queries {
    query  = "${var.scope_key}=${var.default_scope_value}  assessments riskAssessment UntrustedIP\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"ip\", \"details.riskAssessment.assessments.UntrustedIP.code\" as type, user_name, client_name, ip, untrusted_ip_code nodrop\n\n// panel specific\n| where !isBlank(untrusted_ip_code) and untrusted_ip_code matches \"found_on_deny_list\"\n| count by log_id, type, user_name, client_name, ip\n| count by user_name, client_name, ip"
    row_id = "A"
  }


  triggers {
    detection_method  = "LogsStaticCondition"
    min_data_points   = "1"
    resolution_window = "15m"
    threshold         = "3"
    threshold_type    = "LessThanOrEqual"
    time_range        = "15m"
    trigger_type      = "ResolvedCritical"
  }

  triggers {
    detection_method = "LogsStaticCondition"
    min_data_points  = "1"
    threshold        = "3"
    threshold_type   = "GreaterThan"
    time_range       = "15m"
    trigger_type     = "Critical"
  }

}
