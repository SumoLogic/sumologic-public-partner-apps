resource "sumologic_dashboard" "phylum_threat_feed_dashboard" {
  description = "Example dashboard showing total software supply chain threats and how many have been detected through log analysis with Sumologic."
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
        key       = "panelPANE-1D8BA333A628B849"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-509350EAA787E84B"
        structure = "{\"height\":7,\"width\":24,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-71087EF0BABC6A46"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "Match files identified as software supply chain attacks"
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-509350EAA787E84B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   |\nparse \"hash: *\" as candidate_hash\n| lookup * from ${var.scope_key}={{${var.scope_key_variable_display_name}}}  on id=candidate_hash | count by ecosystem | sort by +_count | limit 2"
        query_type   = "Logs"
      }

      title           = "Malicious Packages Detected In Your Environment by Ecosystem"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "Show a count of software supply chain threats by ecosystem"
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-71087EF0BABC6A46"

      query {
        query_key    = "A"
        query_string = "cat ${var.scope_key}={{${var.scope_key_variable_display_name}}}  | count by ecosystem"
        query_type   = "Logs"
      }

      title           = "# Threats by Ecosystem"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "Show a count of software supply chain threats"
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-1D8BA333A628B849"

      query {
        query_key    = "A"
        query_string = "cat ${var.scope_key}={{${var.scope_key_variable_display_name}}}  | count"
        query_type   = "Logs"
      }

      title           = "Count of Total Software Supply Chain Threats"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"Software Supply Chain Threats\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  refresh_interval = "0"
  theme            = "Dark"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1w"
        }
      }
    }
  }

  title = "Phylum Threat Feed Dashboard"
}
