resource "sumologic_log_search" "alerts_by_entity" {
  description         = "Alerts grouped by ZeroFOX protected entities."
  name                = "Alerts by Entity"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| json field=_raw \"entity.name\" as entity\n| timeslice 1d\n| count by _timeslice, entity\n| sort by _timeslice asc\n| transpose row _timeslice column entity as * "
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

resource "sumologic_log_search" "alerts_by_network" {
  description         = "Alerts grouped by network during the period."
  name                = "Alerts by Network"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"alert_type\" \n| json field=_raw \"status\"\n| json field=_raw \"network\"\n| timeslice 1d\n| count by _timeslice, network\n| sort by _timeslice asc\n| transpose row _timeslice column network as * "
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

resource "sumologic_log_search" "alerts_by_status" {
  description         = "Alerts grouped by status for the last 7 days."
  name                = "Alerts by Status"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"status\"\n| timeslice 1d\n| count by _timeslice, status\n| sort by _timeslice asc\n| transpose row _timeslice column status as * "
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

resource "sumologic_log_search" "alerts_by_takedown_status" {
  description         = "Alerts grouped by takedown status."
  name                = "Alerts by Takedown Status"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"status\"\n| json field=_raw \"network\"\n| where status=\"open\"\n| count"
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

resource "sumologic_log_search" "alerts_by_top_rules" {
  description         = "Alerts groups by the most common rules"
  name                = "Alerts by Top Rules"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| json field=_raw \"rule_name\" as rule\n| timeslice 1d\n| count by _timeslice, rule\n| limit 10\n| sort by _timeslice asc\n| transpose row _timeslice column rule as * "
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

resource "sumologic_log_search" "escalated_alerts" {
  description         = "This shows the number of escalated alerts."
  name                = "Escalated Alerts"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"status\"\n| json field=_raw \"network\"\n| json field=_raw \"escalated\"\n| where escalated=\"true\"\n| count"
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

resource "sumologic_log_search" "successful_takedowns" {
  description         = "The total number of alerts that were successfully taken down during the period."
  name                = "Successful Takedowns"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"status\"\n| where status=\"Takedown:Accepted\"\n| count"
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

resource "sumologic_log_search" "total_alerts" {
  description         = "The total alert count during the period"
  name                = "Total Alerts"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"status\"\n| json field=_raw \"network\"\n| count"
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

resource "sumologic_log_search" "total_alerts_by_network" {
  description         = "The total number of alerts by network"
  name                = "Total Alerts by Network"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"network\"\n| count by network"
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
