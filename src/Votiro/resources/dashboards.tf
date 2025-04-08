resource "sumologic_dashboard" "votiro_overview" {
  description = "Overview monitoring dashboard for analysis of Votiro Sanitization engine syslog"
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
        key       = "panel1575DAABAB69BA4C"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panel39D209DB9644A84F"
        structure = "{\"height\":5,\"width\":4,\"x\":16,\"y\":1}"
      }

      layout_structure {
        key       = "panel3BA85DFD8C5B4B4E"
        structure = "{\"height\":5,\"width\":4,\"x\":0,\"y\":1}"
      }

      layout_structure {
        key       = "panel6BD3029590D72948"
        structure = "{\"height\":5,\"width\":4,\"x\":20,\"y\":1}"
      }

      layout_structure {
        key       = "panel6CB809339F53EB4A"
        structure = "{\"height\":1,\"width\":16,\"x\":8,\"y\":0}"
      }

      layout_structure {
        key       = "panel99C13D0083634B48"
        structure = "{\"height\":5,\"width\":4,\"x\":8,\"y\":1}"
      }

      layout_structure {
        key       = "panelB067B445BC776A4A"
        structure = "{\"height\":5,\"width\":4,\"x\":4,\"y\":1}"
      }

      layout_structure {
        key       = "panelD0F09888AA80D948"
        structure = "{\"height\":7,\"width\":24,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panelFDDAEF38882F1A48"
        structure = "{\"height\":5,\"width\":4,\"x\":12,\"y\":1}"
      }

      layout_structure {
        key       = "panelPANE-3FF6D8EB8B718947"
        structure = "{\"height\":1,\"width\":8,\"x\":0,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel1575DAABAB69BA4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| timeslice 1d\n| count by _timeslice, sanitization_result\n| _count as Threats\n| sanitization_result as Status\n| fields - _count, sanitization_result\n| transpose row _timeslice column Status as *"
        query_type   = "Logs"
      }

      title           = "Threats Disarmed"
      visual_settings = "{\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"Number of Threats\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\"},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\"}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":10,\"showAsTable\":false,\"wrap\":false,\"maxWidth\":100},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"},\"title\":{\"fontSize\":15},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel39D209DB9644A84F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| count by sanitization_result\n| where sanitization_result == \"Blocked\""
        query_type   = "Logs"
      }

      title           = " "
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"noDataString\":\"0\",\"option\":\"Latest\",\"label\":\"Blocked\",\"valueFontSize\":35,\"rounding\":0,\"labelFontSize\":12,\"useBackgroundColor\":false,\"sparkline\":{\"show\":false,\"color\":\"\"},\"gauge\":{\"show\":false},\"hideLabel\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel3BA85DFD8C5B4B4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where connector_type == \"File connector\"\n| count by connector_type"
        query_type   = "Logs"
      }

      title           = " "
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"noDataString\":\"0\",\"option\":\"Latest\",\"label\":\"Files\",\"valueFontSize\":35,\"rounding\":0,\"labelFontSize\":12,\"useBackgroundColor\":false,\"sparkline\":{\"show\":false,\"color\":\"#bf2121\"},\"gauge\":{\"show\":false},\"hideLabel\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel6BD3029590D72948"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| count by sanitization_result\n| where sanitization_result == \"Skipped\""
        query_type   = "Logs"
      }

      title           = " "
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"noDataString\":\"0\",\"option\":\"Latest\",\"label\":\"Skipped\",\"valueFontSize\":35,\"rounding\":0,\"labelFontSize\":12,\"useBackgroundColor\":false,\"sparkline\":{\"show\":false,\"color\":\"\"},\"gauge\":{\"show\":false},\"hideLabel\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel99C13D0083634B48"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| count by sanitization_result\n| where sanitization_result == \"Sanitized\""
        query_type   = "Logs"
      }

      title           = " "
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"noDataString\":\"0\",\"option\":\"Latest\",\"label\":\"Sanitized\",\"valueFontSize\":35,\"rounding\":0,\"labelFontSize\":12,\"useBackgroundColor\":false,\"sparkline\":{\"show\":false,\"color\":\"\"},\"gauge\":{\"show\":false},\"hideLabel\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB067B445BC776A4A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| count by connector_type\n| where connector_type == \"Email connector\""
        query_type   = "Logs"
      }

      title           = " "
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"noDataString\":\"0\",\"option\":\"Latest\",\"label\":\"Emails\",\"valueFontSize\":35,\"rounding\":0,\"labelFontSize\":12,\"useBackgroundColor\":false,\"sparkline\":{\"show\":false,\"color\":\"\"},\"gauge\":{\"show\":false},\"hideLabel\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelD0F09888AA80D948"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| count by file_type\n| where ! isNull(file_type)\n| _count as Files\n| fields - _count"
        query_type   = "Logs"
      }

      title           = "Incoming Files"
      visual_settings = "{\"axes\":{\"axisX\":{\"title\":\"File Types \",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"Number of Files\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\"},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\"}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":10,\"showAsTable\":false,\"wrap\":false,\"maxWidth\":100},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"},\"overrides\":[],\"title\":{\"fontSize\":15}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelFDDAEF38882F1A48"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| count by sanitization_result\n| where sanitization_result == \"Partially sanitized\""
        query_type   = "Logs"
      }

      title           = " "
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"noDataString\":\"0\",\"option\":\"Latest\",\"label\":\"Partially Sanitized\",\"valueFontSize\":35,\"rounding\":0,\"labelFontSize\":12,\"useBackgroundColor\":false,\"sparkline\":{\"show\":false,\"color\":\"\"},\"gauge\":{\"show\":false},\"hideLabel\":false}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel6CB809339F53EB4A"
      title                                       = "Scanned Files (Threats)"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"text\":{\"format\":\"markdownV2\"},\"series\":{},\"legend\":{\"enabled\":false},\"title\":{\"fontSize\":15}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-3FF6D8EB8B718947"
      title                                       = " Incoming Traffic (Data Source)"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"text\":{\"format\":\"markdownV2\",\"fontSize\":20,\"verticalAlignment\":\"top\",\"horizontalAlignment\":\"left\"},\"series\":{},\"legend\":{\"enabled\":false},\"title\":{\"fontSize\":15}}"
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

  title = "Votiro - Overview"
}
