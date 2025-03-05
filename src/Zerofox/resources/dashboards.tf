resource "sumologic_dashboard" "zero_fox_cloud_dashboard" {
  description = "This is the ZeroFOX Cloud dashboard, showing all alerts generated during the period presented by different dimensions (network, takedown status, rule, etc)."
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
        key       = "panel107cf452a34d1a47"
        structure = "{\"width\":8,\"height\":6,\"x\":16,\"y\":0}"
      }

      layout_structure {
        key       = "panel20a9bb909b395842"
        structure = "{\"width\":24,\"height\":9,\"x\":0,\"y\":5}"
      }

      layout_structure {
        key       = "panel2647f743bb12084e"
        structure = "{\"width\":8,\"height\":6,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panel3f48515dbba62949"
        structure = "{\"width\":24,\"height\":8,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panel403d61549fc30a4c"
        structure = "{\"width\":8,\"height\":6,\"x\":8,\"y\":0}"
      }

      layout_structure {
        key       = "panel92f09fe89516f844"
        structure = "{\"width\":24,\"height\":8,\"x\":0,\"y\":24}"
      }

      layout_structure {
        key       = "panele924ccb6a742c94e"
        structure = "{\"width\":24,\"height\":8,\"x\":0,\"y\":30}"
      }

      layout_structure {
        key       = "panelf38fd9f2bcc84a4a"
        structure = "{\"width\":24,\"height\":6,\"x\":0,\"y\":36}"
      }

      layout_structure {
        key       = "panelf46ed36e89cd5a47"
        structure = "{\"width\":24,\"height\":8,\"x\":0,\"y\":18}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel107cf452a34d1a47"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"status\"\n| json field=_raw \"network\"\n| json field=_raw \"escalated\"\n| where escalated=\"true\"\n| count"
        query_type   = "Logs"
      }

      title           = "Escalated Alerts"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"label\":\"\",\"useBackgroundColor\":true,\"useNoData\":true,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel20a9bb909b395842"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"alert_type\" \n| json field=_raw \"status\"\n| json field=_raw \"network\"\n| timeslice 1d\n| count by _timeslice, network\n| sort by _timeslice asc\n| transpose row _timeslice column network as * "
        query_type   = "Logs"
      }

      title           = "Alerts by Network"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":false},\"color\":{\"family\":\"Categorical Dark\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel2647f743bb12084e"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"status\"\n| json field=_raw \"network\"\n| count"
        query_type   = "Logs"
      }

      title           = "Total Alerts"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"label\":\"\",\"useBackgroundColor\":true,\"useNoData\":true,\"noDataString\":\"-\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel3f48515dbba62949"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"status\"\n| timeslice 1d\n| count by _timeslice, status\n| sort by _timeslice asc\n| transpose row _timeslice column status as * "
        query_type   = "Logs"
      }

      title           = "Alerts by Status"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":false},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel403d61549fc30a4c"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"status\"\n| where status=\"Takedown:Accepted\"\n| count"
        query_type   = "Logs"
      }

      title           = "Successful Takedowns"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"label\":\"\",\"useBackgroundColor\":true,\"useNoData\":true,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel92f09fe89516f844"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| json field=_raw \"rule_name\" as rule\n| timeslice 1d\n| count by _timeslice, rule\n| limit 10\n| sort by _timeslice asc\n| transpose row _timeslice column rule as * "
        query_type   = "Logs"
      }

      title           = "Alerts by Rule"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":false},\"color\":{\"family\":\"Colorsafe\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panele924ccb6a742c94e"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"status\"\n| json field=_raw \"network\"\n| where status=\"Takedown:Requested\" OR status=\"Takedown:Accepted\" OR status=\"Takedown:Denied\"\n| count by status"
        query_type   = "Logs"
      }

      title           = "Alerts by Takedown Status"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":true,\"wrap\":true},\"color\":{\"family\":\"Sequential 2\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelf38fd9f2bcc84a4a"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"network\"\n| count by network\n| sort by _count\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Total Alerts by Network"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":true,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelf46ed36e89cd5a47"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| json field=_raw \"entity.name\" as entity\n| timeslice 1d\n| count by _timeslice, entity\n| sort by _timeslice asc\n| transpose row _timeslice column entity as * "
        query_type   = "Logs"
      }

      title           = "Alerts by Entity"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":false},\"color\":{\"family\":\"Sequential 1\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"overrides\":[],\"series\":{}}"
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

  title = "ZeroFOX Cloud - Dashboard"
}
