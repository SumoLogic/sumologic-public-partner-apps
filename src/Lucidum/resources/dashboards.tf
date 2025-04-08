resource "sumologic_dashboard" "lucidum_dashboard" {
  description = "Lucidum dashboard provides information about assets, data sources, services, locations, risk factors and ports"
  folder_id   = sumologic_folder.integration_folder.id

  variable {
    allow_multi_select = "false"
    default_value      = var.default_scope_value
    display_name = var.scope_key_variable_display_name
    hide_from_ui       = "false"
    include_all_option = "true"
    name = var.scope_key_variable_display_name
    source_definition {
      csv_variable_source_definition {
        values = "${var.default_scope_value}"
      }
    }
  }

  layout {
    grid {
      layout_structure {
        key       = "panel0C7CF90ABED18A4E"
        structure = "{\"height\":13,\"width\":12,\"x\":0,\"y\":5}"
      }

      layout_structure {
        key       = "panel38260F7188074B45"
        structure = "{\"height\":12,\"width\":12,\"x\":0,\"y\":18}"
      }

      layout_structure {
        key       = "panel39C42FE4951FE94F"
        structure = "{\"height\":10,\"width\":12,\"x\":12,\"y\":20}"
      }

      layout_structure {
        key       = "panel46683720AC46794C"
        structure = "{\"height\":10,\"width\":12,\"x\":12,\"y\":10}"
      }

      layout_structure {
        key       = "panel4AA09FD9A41A4A4D"
        structure = "{\"height\":5,\"width\":12,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelDD029C638DA05B4A"
        structure = "{\"height\":10,\"width\":12,\"x\":12,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel0C7CF90ABED18A4E"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )| parse regex field=Services\"(?:\\[\\\"|,\\\"|^\\\")(?<service>[^\\\"]+)\" multi | count_distinct(asset) group by service"
        query_type   = "Logs"
      }

      title           = "Top 10 Services"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"maxNumOfSlices\":10,\"innerRadius\":\"50%\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel38260F7188074B45"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )| parse regex field=Risk_Factors\"(?:\\[\\\"|,\\\"|^\\\")(?<riskfactor>[^\\\"]+)\" multi | count_distinct(asset) group by riskfactor"
        query_type   = "Logs"
      }

      title           = "Risk Factors"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"maxNumOfSlices\":30,\"innerRadius\":\"50%\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel39C42FE4951FE94F"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )| parse regex field=Ports\"(?:\\[\\\"|,\\\"|^\\\")(?<ports>[^\\\"]+)\" multi | count_distinct(asset) group by ports"
        query_type   = "Logs"
      }

      title           = "Ports"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"innerRadius\":\"50%\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel46683720AC46794C"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )| where !isNull(location) | count_distinct(asset) group by location"
        query_type   = "Logs"
      }

      title           = "Locations"
      visual_settings = "{\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel4AA09FD9A41A4A4D"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  ) | count_distinct(asset)"
        query_type   = "Logs"
      }

      title           = "Number of Unique Assets"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"\",\"valueFontSize\":36}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelDD029C638DA05B4A"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )| parse regex field=Data_Sources\"(?:\\[\\\"|,\\\"|^\\\")(?<datasource>[^\\\"]+)\" multi | count_distinct(asset) group by datasource"
        query_type   = "Logs"
      }

      title           = "Data Sources"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"maxNumOfSlices\":30,\"innerRadius\":\"50%\"},\"series\":{}}"
    }
  }

  refresh_interval = "0"
  theme            = "Dark"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "Lucidum Dashboard"
}
