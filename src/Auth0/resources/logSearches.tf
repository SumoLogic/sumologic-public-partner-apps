resource "sumologic_log_search" "client_version_usage" {
  name                = "Client Version Usage"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"auth0_client.name\", \"auth0_client.version\" \n| concat(%auth0_client.name, \" \", %auth0_client.version) as auth0_client_version \n| timeslice 1h \n| count by _timeslice, auth0_client_version \n| transpose row _timeslice column auth0_client_version"
  run_by_receipt_time = "false"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1w"
        }
      }
    }
  }
}

resource "sumologic_log_search" "connection_types_per_hour" {
  name                = "Connection Types per Hour"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"data.connection\" as connection\n| where connection != \"\" \n| timeslice by 1h \n| count by _timeslice, connection \n| transpose row _timeslice column connection"
  run_by_receipt_time = "false"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }
}

resource "sumologic_log_search" "guardian_mfa" {
  name                = "Guardian MFA"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"data.type\" as type\n| where type matches(\"gd_*\") \n| timeslice by 1h \n| count by _timeslice, type \n| transpose row _timeslice column type"
  run_by_receipt_time = "false"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1w"
        }
      }
    }
  }
}

resource "sumologic_log_search" "logins_by_client_and_country" {
  name                = "Logins by Client and Country"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"data.type\", \"data.client_name\", \"data.ip\" as type, client_name, ip\n| where type = \"s\"\n| lookup country_name from geo://location on ip=ip\n| count by client_name, country_name\n| transpose row client_name column country_name"
  run_by_receipt_time = "false"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }
}

resource "sumologic_log_search" "logins_by_client_per_day" {
  name                = "Logins by Client per Day"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"data.type\", \"data.client_name\" as type, client_name\n| where client_name != \"\" and type = \"s\"\n| timeslice by 1d \n| count by _timeslice, client_name \n| transpose row _timeslice column client_name"
  run_by_receipt_time = "false"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1w"
        }
      }
    }
  }
}

resource "sumologic_log_search" "logins_geolocation" {
  name                = "Logins Geolocation"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"data.type\", \"data.ip\" as type, ip\n| where type matches \"s\"\n| lookup latitude, longitude, country_code, country_name, region, city from geo://location on ip = ip\n| count by latitude, longitude, country_code, country_name, region, city\n| sort _count"
  run_by_receipt_time = "false"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }
}

resource "sumologic_log_search" "logins_per_hour" {
  name                = "Logins per Hour"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"data.type\" as type\n| if(type in (\"fp\", \"fu\"), \"failure\", if(type = \"s\", \"success\", \"-\")) as login_result\n| where login_result != \"-\"\n| timeslice 1h\n| count by _timeslice, login_result\n| transpose row _timeslice column login_result"
  run_by_receipt_time = "false"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1w"
        }
      }
    }
  }
}

resource "sumologic_log_search" "top_10__source_i_ps_by_failed_login" {
  name                = "Top10 Source IPs by Failed Login"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"data.type\", \"data.ip\" as type, ip\n| where type in (\"fp\", \"fu\")\n| where ip != \"\" \n| count ip \n| top 10 ip by _count"
  run_by_receipt_time = "false"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }
}

resource "sumologic_log_search" "top_10_clients" {
  name                = "Top 10 Clients"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"data.client_name\" as client_name\n| where client_name != \"\" \n| count client_name \n| top 10 client_name by _count"
  run_by_receipt_time = "false"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }
}

resource "sumologic_log_search" "top_10_operating_systems_by_unique_user" {
  name                = "Top 10 Operating Systems by Unique User"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"data.user_name\", \"data.user_agent\", \"data.client_name\" as user_name, user_agent, client_name\n| parse field=user_agent \"/ * \" as user_os \n| count_distinct(user_name) group by user_os \n| top 10 user_os by _count_distinct"
  run_by_receipt_time = "false"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1w"
        }
      }
    }
  }
}

resource "sumologic_log_search" "top_10_recent_errors" {
  name                = "Top 10 Recent Errors"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"data.type\", \"data.connection\", \"data.description\", \"data.client_name\" as type, connection, description, client_name\n| where type != \"slo\" \n| count client_name, connection, description \n| top 10 client_name, connection, description by _count"
  run_by_receipt_time = "false"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-3d"
        }
      }
    }
  }
}

resource "sumologic_log_search" "top_10_user_agents" {
  name                = "Top 10 User Agents"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"data.user_agent\" as user_agent\n| parse field=user_agent \"* \" as user_agent \n| count user_agent \n| top 10 user_agent by _count"
  run_by_receipt_time = "false"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1w"
        }
      }
    }
  }
}

resource "sumologic_log_search" "top_10_users_by_failed_login" {
  name                = "Top 10 Users by Failed Login"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"data.type\", \"data.user_name\" as type, user_name\n| where type in (\"fp\", \"fu\")\n| where user_name != \"\" \n| count user_name \n| top 10 user_name by _count"
  run_by_receipt_time = "false"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }
}

resource "sumologic_log_search" "top_10_users_by_successful_login" {
  name                = "Top 10 Users by Successful Login"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"data.type\", \"data.user_name\" as type, user_name\n| where type = \"s\" \n| where user_name != \"\" \n| count user_name \n| top 10 user_name by _count"
  run_by_receipt_time = "false"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }
}
