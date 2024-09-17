resource "sumologic_log_search" "alerts_by_product" {
  description         = "Display alerts categorized by different products like domains, social_media, mobile_apps, ecommerce, crypto, email, paid_ads"
  name                = "Alerts By Product"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| dedup id\n| sort by product"
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
  description         = "Status-based alert analysis and reporting."
  name                = "Alerts By Status"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| dedup id\n| sort by queue_state"
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

resource "sumologic_log_search" "resolved_alerts" {
  description         = "Identify and Display the report of taken_down status "
  name                = "Resolved Alerts"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where queue_state=\"taken_down\"\n| dedup id"
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

resource "sumologic_log_search" "top_10_alerts_by_product" {
  description         = "Aggregate alert counts segmented by product."
  name                = "Top 10 Alerts By Product"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| dedup id\n| count by product\n| sort by _count\n| limit 10"
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
  description         = "Overview of the total number of alerts generated over a specified period."
  name                = "Total Alerts"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| dedup id"
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

resource "sumologic_log_search" "verified_alerts" {
  description         = "Displays the report of needs_confirmation and reported status alerts"
  name                = "Verified Alerts"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where queue_state in (\"reported\", \"needs_confirmation\")\n| dedup id"
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
