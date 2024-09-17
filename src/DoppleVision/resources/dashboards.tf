resource "sumologic_dashboard" "doppel_vision_dashboard" {
  description = "Comprehensive overview of digital risk protection metrics and alerts"
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
        key       = "panelPANE-13FB1B5988C95B4D"
        structure = "{\"height\":6,\"width\":8,\"x\":8,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-22C2BCAAA39FA84E"
        structure = "{\"height\":6,\"width\":8,\"x\":16,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-2B67FA0C8BF5EA4E"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-8D2D86A6B6ACF943"
        structure = "{\"height\":7,\"width\":24,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-A8B4F5DD9195C84F"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-F3F93290BD99494B"
        structure = "{\"height\":6,\"width\":8,\"x\":0,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "Aggregate alert counts segmented by product."
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-8D2D86A6B6ACF943"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where id = \"{{AlertId}}\" or \"{{AlertId}}\" = \"*\"\n| where product = \"{{ProductFilter}}\" or \"{{ProductFilter}}\" = \"*\"\n| where queue_state = \"{{AlertStatus}}\" or \"{{AlertStatus}}\" = \"*\" \n| dedup id\n| count by product\n| if (isBlank(product), \"unknown\", product) as product\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Total Alerts By Product"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"product\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"count\"}},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"distribution\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "Display alerts categorized by different products like domains, social_media, mobile_apps, ecommerce, crypto, email, paid_ads"
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-A8B4F5DD9195C84F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where id = \"{{AlertId}}\" or \"{{AlertId}}\" = \"*\"\n| where product = \"{{ProductFilter}}\" or \"{{ProductFilter}}\" = \"*\"\n| where queue_state = \"{{AlertStatus}}\" or \"{{AlertStatus}}\" = \"*\"\n| dedup id\n| timeslice 1d\n| count by _timeslice, product\n| if (isBlank(product), \"unknown\", product) as product\n| sort by _timeslice asc\n| transpose row _timeslice column product as * "
        query_type   = "Logs"
      }

      title           = "Alerts By Product"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "Displays the report of needs_confirmation and reported status alerts"
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-13FB1B5988C95B4D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| where id = \"{{AlertId}}\" or \"{{AlertId}}\" = \"*\"\n| where product = \"{{ProductFilter}}\" or \"{{ProductFilter}}\" = \"*\"\n| where queue_state = \"{{AlertStatus}}\" or \"{{AlertStatus}}\" = \"*\"\n| where queue_state=\"reported\" or queue_state=\"needs_confirmation\"\n| dedup id\n| count"
        query_type   = "Logs"
      }

      title           = "Verified Alerts"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"\",\"useBackgroundColor\":true,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":0,\"to\":1000000,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "Identify and Display the report of taken_down status "
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-22C2BCAAA39FA84E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where id = \"{{AlertId}}\" or \"{{AlertId}}\" = \"*\"\n| where product = \"{{ProductFilter}}\" or \"{{ProductFilter}}\" = \"*\"\n| where queue_state = \"{{AlertStatus}}\" or \"{{AlertStatus}}\" = \"*\"\n| where queue_state=\"taken_down\"\n| dedup id\n| count"
        query_type   = "Logs"
      }

      title           = "Resolved Alerts"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"\",\"useBackgroundColor\":true,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":0,\"to\":1000000,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "Overview of the total number of alerts generated over a specified period."
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-F3F93290BD99494B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where id = \"{{AlertId}}\" or \"{{AlertId}}\" = \"*\"\n| where product = \"{{ProductFilter}}\" or \"{{ProductFilter}}\" = \"*\"\n| where queue_state = \"{{AlertStatus}}\" or \"{{AlertStatus}}\" = \"*\"\n| dedup id\n| count"
        query_type   = "Logs"
      }

      title           = "Total Alerts"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"\",\"useBackgroundColor\":true,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":0,\"to\":1000000,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "Status-based alert analysis and reporting."
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-2B67FA0C8BF5EA4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where id = \"{{AlertId}}\" or \"{{AlertId}}\" = \"*\"\n| where product = \"{{ProductFilter}}\" or \"{{ProductFilter}}\" = \"*\"\n| where queue_state = \"{{AlertStatus}}\" or \"{{AlertStatus}}\" = \"*\"\n| dedup id\n| timeslice 1d\n| count by _timeslice, queue_state\n| if (isBlank(queue_state), \"unknown\", queue_state) as queue_state\n| sort by _timeslice asc\n| transpose row _timeslice column queue_state as * "
        query_type   = "Logs"
      }

      title           = "Alerts By Status"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"overrides\":[]}"
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

  title = "Doppel Vision Dashboard"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "AlertId"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "AlertId"

    source_definition {
      log_query_variable_source_definition {
        field = "id"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | dedup id"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "AlertStatus"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "AlertStatus"

    source_definition {
      log_query_variable_source_definition {
        field = "queue_state"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | dedup queue_state"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "ProductFilter"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "ProductFilter"

    source_definition {
      log_query_variable_source_definition {
        field = "product"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | dedup product"
      }
    }
  }
}
