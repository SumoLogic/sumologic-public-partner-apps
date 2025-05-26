resource "sumologic_dashboard" "mimecast_email_activity" {
  description = "Mimecast Email Activity dashboard"
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
        key       = "panel56BF5E94B563694F"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panel957E209281B33845"
        structure = "{\"height\":14,\"width\":7,\"x\":17,\"y\":14}"
      }

      layout_structure {
        key       = "panel98E8965BAED78A42"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":6}"
      }

      layout_structure {
        key       = "panelF5B9A7A9B31F1A4A"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-46553C578663C942"
        structure = "{\"height\":14,\"width\":9,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-5B143E338A1CAA4C"
        structure = "{\"height\":14,\"width\":8,\"x\":9,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-776FC2639745AA4A"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel56BF5E94B563694F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where Act = \"Acc\" and dir = \"Internal\" \n| timeslice 1d \n| count as count by _timeslice \n| sort by _timeslice asc\n"
        query_type   = "Logs"
      }

      title           = "Internal Email"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":0,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":2},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\"}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel957E209281B33845"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where hld != null \n| count by hld \n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Quarantined (Held) Messages"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"Reason held\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\"}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":false},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel98E8965BAED78A42"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where Act = \"Acc\" and dir = \"External\" \n| timeslice 1d \n| count as count by _timeslice \n| sort by _timeslice asc\n"
        query_type   = "Logs"
      }

      title           = "External Email"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":0,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":2},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"Date\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\"}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{\"A__count\":{\"visible\":true}},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelF5B9A7A9B31F1A4A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where Act = \"Acc\" and dir = \"Outbound\" \n| timeslice 1d \n| count as count by _timeslice \n| sort by _timeslice asc\n"
        query_type   = "Logs"
      }

      title           = "Outbound Email"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":0,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":2},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"Date\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\"}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-46553C578663C942"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where rejtype != null \n| count by rejtype \n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Rejections"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\",\"aggregationType\":\"count\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"Rejection Type\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\"}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":false},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-5B143E338A1CAA4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where delivered = \"false\" and rejtype != null \n| count by rejtype \n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Delivery Failures"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"Failure Type\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\"}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":false},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-776FC2639745AA4A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where Act = \"Acc\" and dir = \"Inbound\" \n| timeslice 1d \n| count as count by _timeslice \n| sort by _timeslice asc\n"
        query_type   = "Logs"
      }

      title           = "Inbound Email"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":0,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":2},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"Date\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\"}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{\"A__count\":{\"visible\":true}},\"overrides\":[]}"
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

  title = "Mimecast - Email Activity"
}

resource "sumologic_dashboard" "mimecast_spam_detection" {
  description = "Mimecast Spam Detection dashboard"
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
        key       = "panel8BEC7BA9B785C849"
        structure = "{\"height\":31,\"width\":12,\"x\":12,\"y\":4}"
      }

      layout_structure {
        key       = "panelPANE-3EB606F8BD6BA94B"
        structure = "{\"height\":17,\"width\":12,\"x\":0,\"y\":4}"
      }

      layout_structure {
        key       = "panelPANE-4009ED8EBDF62B48"
        structure = "{\"height\":4,\"width\":24,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-5C3E2F4788F64944"
        structure = "{\"height\":14,\"width\":12,\"x\":0,\"y\":21}"
      }

      layout_structure {
        key       = "panelPANE-9CA051C2BE030A4C"
        structure = "{\"height\":16,\"width\":24,\"x\":0,\"y\":35}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8BEC7BA9B785C849"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where Act = \"Rej\"\n| where spamscore > spamlimit\n| count by rcpt \n| limit 10 \n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Top 10 Targeted Users"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"Recipient\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\"}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":false},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-3EB606F8BD6BA94B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where Act = \"Rej\"\n| where spamscore > spamlimit\n| count by spaminfo \n| limit 10 \n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Top 10 Spam Signature Detections"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"Spam Signature\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\"}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":false},\"color\":{\"family\":\"Categorical Default\"},\"series\":{\"Xls.Dropper.Agent-7401607-0\":{\"visible\":true},\"Xls.Dropper.Agent-7464037-0\":{\"visible\":true},\"Xls.Dropper.Agent-7364164-0\":{\"visible\":true},\"Doc.Dropper.Agent-7424370-0\":{\"visible\":true}},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-4009ED8EBDF62B48"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where Act = \"Rej\"\n| where spamscore > spamlimit\n| count"
        query_type   = "Logs"
      }

      title           = "Email Spam Detections"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Average\",\"label\":\"Virus's Rejected\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":true,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"\"},\"gauge\":{\"show\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-5C3E2F4788F64944"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where Act = \"Rej\"\n| where spamscore > spamlimit\n| count by sender"
        query_type   = "Logs"
      }

      title           = "Spam Detection by sender"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"50%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{\"\":{\"visible\":false}},\"legend\":{\"enabled\":false,\"wrap\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-9CA051C2BE030A4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where Act = \"Rej\"\n| where spamscore > spamlimit\n| lookup latitude, longitude, country_code, country_name, region, city, postal_code from geo://location on ip = ip \n| count by latitude, longitude, country_code, country_name, region, city, postal_code \n| sort _count"
        query_type   = "Logs"
      }

      title           = "Spam Detection by Source IP"
      visual_settings = "{\"general\":{\"mode\":\"map\",\"type\":\"map\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"series\":{},\"map\":{\"layerType\":\"Heat\"}}"
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

  title = "Mimecast - Spam Detection"
}

resource "sumologic_dashboard" "mimecast_tls" {
  description = "Mimecast Transport Layer Security dashboard"
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
        key       = "panel021132E39FF72842"
        structure = "{\"height\":16,\"width\":12,\"x\":0,\"y\":22}"
      }

      layout_structure {
        key       = "panel0F0905089BFE1A47"
        structure = "{\"height\":6,\"width\":6,\"x\":18,\"y\":0}"
      }

      layout_structure {
        key       = "panel8F5166428ADDFA46"
        structure = "{\"height\":16,\"width\":12,\"x\":12,\"y\":6}"
      }

      layout_structure {
        key       = "panelC39C9EF5A69FB94E"
        structure = "{\"height\":6,\"width\":6,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panelC930559C81F83840"
        structure = "{\"height\":16,\"width\":12,\"x\":12,\"y\":22}"
      }

      layout_structure {
        key       = "panelEB2BA551A3890A4B"
        structure = "{\"height\":6,\"width\":6,\"x\":6,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-361E05BA9C22E945"
        structure = "{\"height\":6,\"width\":6,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-6D5CAF5C9F968B42"
        structure = "{\"height\":16,\"width\":12,\"x\":0,\"y\":6}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel021132E39FF72842"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where usetls = \"No\" and dir = \"Inbound\" \n| split rcpt delim='@' extract 1 as user, 2 as domain \n| count as count by domain \n| sort by count"
        query_type   = "Logs"
      }

      title           = "Inbound Sending Domains Not Using TLS"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel0F0905089BFE1A47"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where usetls = \"No\" and delivered = \"true\" and dir != null\n| count"
        query_type   = "Logs"
      }

      title           = "Messages Delivered Without TLS"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Average\",\"label\":\"Messages Delivered Without TLS\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":true,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8F5166428ADDFA46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where tlsver != null \n| count as count by cphr \n| sort cphr"
        query_type   = "Logs"
      }

      title           = "Top Ciphers"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"Cipher Type\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\"}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelC39C9EF5A69FB94E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where delivered = \"true\" and tlsver != null and dir != null\n| count"
        query_type   = "Logs"
      }

      title           = "Messages Delivered using TLS"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Average\",\"label\":\"Messages Delivered Using TLS\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":true,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelC930559C81F83840"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where usetls = \"No\" and dir = \"Outbound\" \n| split rcpt delim='@' extract 1 as user, 2 as domain \n| count as count by domain \n| sort by count"
        query_type   = "Logs"
      }

      title           = "Outbound Recipient Domains Not Using TLS"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelEB2BA551A3890A4B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where act = \"Acc\" and tlsver = null and dir != null\n| count"
        query_type   = "Logs"
      }

      title           = "Messages Received without using TLS"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Average\",\"label\":\"Messages Received Without TLS\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":true,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-361E05BA9C22E945"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where act = \"Acc\" and tlsver != null and dir != null\n| count"
        query_type   = "Logs"
      }

      title           = "Messages Received using TLS"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Average\",\"label\":\"Messages Received Using TLS\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":true,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#16943e\"},\"gauge\":{\"show\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-6D5CAF5C9F968B42"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where tlsver != null \n| timeslice 1d \n| count by tlsver, _timeslice \n| transpose row _timeslice column tlsver"
        query_type   = "Logs"
      }

      title           = "TLS Versions Over Time"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"Date\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\"}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
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

  title = "Mimecast - TLS"
}

resource "sumologic_dashboard" "mimecast_ttp_url_protect" {
  description = "Mimecast Targeted Threat Protection - URL Protect dashboard"
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
        key       = "panel66744782AC58384C"
        structure = "{\"height\":15,\"width\":12,\"x\":12,\"y\":27}"
      }

      layout_structure {
        key       = "panel7AC83870823DC944"
        structure = "{\"height\":15,\"width\":12,\"x\":0,\"y\":27}"
      }

      layout_structure {
        key       = "panelB5706D15B12F6B48"
        structure = "{\"height\":23,\"width\":24,\"x\":0,\"y\":42}"
      }

      layout_structure {
        key       = "panelB6D5BAD7A576DA49"
        structure = "{\"height\":15,\"width\":12,\"x\":12,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-364F802C9A4A894B"
        structure = "{\"height\":15,\"width\":12,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-90D94CE393275B4E"
        structure = "{\"height\":12,\"width\":24,\"x\":0,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "TTP"
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB5706D15B12F6B48"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where url != null and action in (\"Block\", \"Browser Isolation\") \n| count as count by recipient, sender, subject, url, sourceip \n| sort by count desc"
        query_type   = "Logs"
      }

      title           = "URL Click Log"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":25,\"fontSize\":12,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel66744782AC58384C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where url != null and action = \"Browser Isolation\" \n| count by url \n| limit 10 \n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Browser Isolation URLs"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"URL\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\"}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel7AC83870823DC944"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where url != null and action = \"Block\" \n| count by url \n| limit 10 \n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Top 10 Blocked URLs"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"URL\",\"hideLabels\":false},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\",\"hideLabels\":false},\"axisY2\":{\"hideLabels\":true}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":false},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB6D5BAD7A576DA49"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where url != null \n| count by urlcategory \n| sort by _count"
        query_type   = "Logs"
      }

      title           = "URL Categories"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"50%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"legend\":{\"enabled\":false,\"wrap\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-364F802C9A4A894B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where url != null \n| count by route \n| sort by _count"
        query_type   = "Logs"
      }

      title           = " URL Source Route"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"Route\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\"}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-90D94CE393275B4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto\n| where action != \"None\" \n| where !isNull(action) \n| timeslice 1d \n| count by action, _timeslice \n| transpose row _timeslice column action \n| sort by _timeslice asc"
        query_type   = "Logs"
      }

      title           = "URL Events"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":0,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":2},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"Volume\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
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

  title = "Mimecast - TTP URL Protect"
}

resource "sumologic_dashboard" "mimecast_virus_detection" {
  description = "Mimecast Virus Detection dashboard"
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
        key       = "panel8BEC7BA9B785C849"
        structure = "{\"height\":31,\"width\":12,\"x\":12,\"y\":4}"
      }

      layout_structure {
        key       = "panelPANE-3EB606F8BD6BA94B"
        structure = "{\"height\":17,\"width\":12,\"x\":0,\"y\":4}"
      }

      layout_structure {
        key       = "panelPANE-4009ED8EBDF62B48"
        structure = "{\"height\":4,\"width\":24,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-5C3E2F4788F64944"
        structure = "{\"height\":14,\"width\":12,\"x\":0,\"y\":21}"
      }

      layout_structure {
        key       = "panelPANE-9CA051C2BE030A4C"
        structure = "{\"height\":16,\"width\":24,\"x\":0,\"y\":35}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8BEC7BA9B785C849"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where virus != null \n| count by rcpt \n| limit 10 \n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Top 10 Targeted Users"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"Recipient\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\"}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":false},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-3EB606F8BD6BA94B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where virus != null \n| count by virus \n| limit 10 \n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Top 10 Virus Detections"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"Virus Signatures\"},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"title\":\"Volume\"}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":false},\"color\":{\"family\":\"Categorical Default\"},\"series\":{\"Xls.Dropper.Agent-7401607-0\":{\"visible\":true},\"Xls.Dropper.Agent-7464037-0\":{\"visible\":true},\"Xls.Dropper.Agent-7364164-0\":{\"visible\":true},\"Doc.Dropper.Agent-7424370-0\":{\"visible\":true}},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-4009ED8EBDF62B48"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where virus != null \n| count"
        query_type   = "Logs"
      }

      title           = "Email Virus Rejections"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Average\",\"label\":\"Virus's Rejected\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":true,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"\"},\"gauge\":{\"show\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-5C3E2F4788F64944"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where virus != null \n| count by fileext"
        query_type   = "Logs"
      }

      title           = "Virus Detection by File Extension"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"50%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{\"\":{\"visible\":false}},\"legend\":{\"enabled\":false,\"wrap\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-9CA051C2BE030A4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json auto \n| where virus != null \n| lookup latitude, longitude, country_code, country_name, region, city, postal_code from geo://location on ip = ip \n| count by latitude, longitude, country_code, country_name, region, city, postal_code \n| sort _count"
        query_type   = "Logs"
      }

      title           = "Virus Detection by Source IP"
      visual_settings = "{\"general\":{\"mode\":\"map\",\"type\":\"map\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"series\":{},\"map\":{\"layerType\":\"Heat\"}}"
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

  title = "Mimecast - Virus Detection"
}
