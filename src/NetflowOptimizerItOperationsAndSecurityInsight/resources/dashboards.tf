resource "sumologic_dashboard" "net_flow_flows_allowed_and_rejected" {
  description = "Dashboard monitoring traffic flows in your data center and clouds. It provides details for inbound/outbound traffic as well as accepted/rejected network conversations."
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
        key       = "panel10C88979B3215942"
        structure = "{\"height\":1,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panel324FA70D8A00C843"
        structure = "{\"height\":3,\"width\":6,\"x\":12,\"y\":1}"
      }

      layout_structure {
        key       = "panel3FAC817DBF54AA46"
        structure = "{\"height\":9,\"width\":6,\"x\":12,\"y\":4}"
      }

      layout_structure {
        key       = "panel459294379BF30843"
        structure = "{\"height\":9,\"width\":6,\"x\":18,\"y\":4}"
      }

      layout_structure {
        key       = "panel54973FDD8992CA46"
        structure = "{\"height\":9,\"width\":6,\"x\":12,\"y\":13}"
      }

      layout_structure {
        key       = "panel69FA742398C60B40"
        structure = "{\"height\":9,\"width\":6,\"x\":18,\"y\":13}"
      }

      layout_structure {
        key       = "panel8356BFA490990B43"
        structure = "{\"height\":9,\"width\":6,\"x\":6,\"y\":13}"
      }

      layout_structure {
        key       = "panelA6D9559FA9A6BA41"
        structure = "{\"height\":9,\"width\":6,\"x\":0,\"y\":13}"
      }

      layout_structure {
        key       = "panelA863AFB3B4293943"
        structure = "{\"height\":3,\"width\":6,\"x\":18,\"y\":1}"
      }

      layout_structure {
        key       = "panelB34D1C6DBEE99940"
        structure = "{\"height\":3,\"width\":6,\"x\":6,\"y\":1}"
      }

      layout_structure {
        key       = "panelD73BD373953E8840"
        structure = "{\"height\":3,\"width\":6,\"x\":0,\"y\":1}"
      }

      layout_structure {
        key       = "panelDF26C19DBB6D7946"
        structure = "{\"height\":9,\"width\":6,\"x\":0,\"y\":4}"
      }

      layout_structure {
        key       = "panelF0A956A79D37C94E"
        structure = "{\"height\":9,\"width\":6,\"x\":6,\"y\":4}"
      }

      layout_structure {
        key       = "panelPANE-2AA602CFA79BD949"
        structure = "{\"height\":1,\"width\":12,\"x\":0,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel324FA70D8A00C843"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"inbound\" and action=\"R\" \n| sum(flow_count) as flows"
        query_type   = "Logs"
      }

      title           = "Inbound Rejected"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"label\":\"Flows\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":0,\"valueFontSize\":32,\"labelFontSize\":20,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel3FAC817DBF54AA46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\"\n| where action=\"R\" \n| concat(src_ip, \" (\",exp_ip,\") \") as Source_IP \n| sum(flow_count) as Flows by Source_IP \n| sort by -Flows \n| Limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Source IP Rejected"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Source IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel459294379BF30843"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where action=\"R\" \n| concat(dest_ip, \" (\",exp_ip,\") \") as Destination_IP \n| sum(flow_count) as Flows by Destination_IP \n| sort by -Flows \n| Limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Destination IP Rejected"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Source IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel54973FDD8992CA46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where action=\"R\" and protocol=6 \n| sum(flow_count) as Flows by dest_port \n| sort by -Flows \n| Limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 TCP Ports Rejected"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Source IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel69FA742398C60B40"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where action=\"R\" and protocol=17 \n| sum(flow_count) as Flows by dest_port \n| sort by -Flows \n| Limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 UDP Ports Rejected"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Source IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8356BFA490990B43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where action=\"A\" and protocol=17 \n| sum(flow_count) as Flows by dest_port \n| sort by -Flows \n| Limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 UDP Ports Accepted"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Source IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelA6D9559FA9A6BA41"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where action=\"A\" and protocol=6 \n| sum(flow_count) as Flows by dest_port \n| sort by -Flows \n| Limit 10 "
        query_type   = "Logs"
      }

      title           = "Top 10 TCP Ports Accepted"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Source IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelA863AFB3B4293943"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"outbound\" and action=\"R\" \n| sum(flow_count) as flows"
        query_type   = "Logs"
      }

      title           = "Outbound Rejected"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"label\":\"Flows\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":0,\"valueFontSize\":32,\"labelFontSize\":20,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB34D1C6DBEE99940"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"outbound\" and action=\"A\" \n| sum(flow_count) as flows"
        query_type   = "Logs"
      }

      title           = "Outbound Accepted"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"label\":\"Flows\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":0,\"valueFontSize\":32,\"labelFontSize\":20,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelD73BD373953E8840"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"inbound\" and action=\"A\" \n| sum(flow_count) as flows"
        query_type   = "Logs"
      }

      title           = "Inbound Accepted"
      visual_settings = "{\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"label\":\"Flows\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":0,\"valueFontSize\":32,\"labelFontSize\":20,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false}},\"series\":{},\"title\":{\"fontSize\":14}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelDF26C19DBB6D7946"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where  action=\"A\" \n| concat(src_ip, \" (\",exp_ip,\") \") as Source_IP \n| sum(flow_count) as Flows by Source_IP \n| sort by -Flows \n| Limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Source IP Accepted"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Source IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelF0A956A79D37C94E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where action=\"A\" \n| concat(dest_ip, \" (\",exp_ip,\") \") as Destination_IP \n| sum(flow_count) as Flows by Destination_IP \n| sort by -Flows \n| Limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Destination IP Accepted"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Source IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel10C88979B3215942"
      title                                       = "Network Traffic Rejected"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"text\":{\"format\":\"markdownV2\",\"horizontalAlignment\":\"center\",\"backgroundColor\":\"#066180\",\"textColor\":\"white\"},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-2AA602CFA79BD949"
      title                                       = "Network Traffic Accepted"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"text\":{\"format\":\"markdownV2\",\"horizontalAlignment\":\"left\",\"backgroundColor\":\"#066180\",\"textColor\":\"white\",\"verticalAlignment\":\"top\"},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  refresh_interval = "0"
  theme            = "Dark"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1h"
        }
      }
    }
  }

  title = "NetFlow - Flows Allowed and Rejected"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "dest_ip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "dest_ip"

    source_definition {
      log_query_variable_source_definition {
        field = "dest_ip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"dest_ip\" \"nfc_id\" \n| json \"dest_ip\",\"nfc_id\" \n| where nfc_id=20062 \n| fields dest_ip"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "dest_port"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "dest_port"

    source_definition {
      log_query_variable_source_definition {
        field = "dest_port"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"dest_port\" \"nfc_id\" \n| json \"dest_port\",\"nfc_id\" \n| where nfc_id=20062 \n| fields dest_port"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "exp_ip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "exp_ip"

    source_definition {
      log_query_variable_source_definition {
        field = "exp_ip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"exp_ip\" \"nfc_id\"\n| json \"exp_ip\",\"nfc_id\" \n| where nfc_id=20062 \n| fields exp_ip"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "nfo_hostname"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "nfo_hostname"

    source_definition {
      log_query_variable_source_definition {
        field = "nfo_hostname"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfo_hostname\" \"nfc_id\"\n| json \"nfo_hostname\",\"nfc_id\" \n| where nfc_id=20062 \n| fields nfo_hostname"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "protocol"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "protocol"

    source_definition {
      log_query_variable_source_definition {
        field = "protocol"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"protocol\" \"nfc_id\" \n| json \"protocol\",\"nfc_id\" \n| where nfc_id=20062 \n| fields protocol"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "src_ip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "src_ip"

    source_definition {
      log_query_variable_source_definition {
        field = "src_ip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"src_ip\" \"nfc_id\" \n| json \"src_ip\",\"nfc_id\" \n| where nfc_id=20062 \n| fields src_ip"
      }
    }
  }
}

resource "sumologic_dashboard" "net_flow_security_monitoring_communications_with_malicious_hosts" {
  description = "Dashboard monitoring threats on your network, categorized by threat feed and reputation. You can view hosts affected by threats and trends over time."
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
        key       = "panel064B942B858D0B40"
        structure = "{\"height\":5,\"width\":12,\"x\":0,\"y\":9}"
      }

      layout_structure {
        key       = "panel093F76E58725AB4C"
        structure = "{\"height\":5,\"width\":6,\"x\":0,\"y\":4}"
      }

      layout_structure {
        key       = "panel1A81D2EC8F1EEB4D"
        structure = "{\"height\":5,\"width\":6,\"x\":18,\"y\":4}"
      }

      layout_structure {
        key       = "panel8221D14D8C0D484C"
        structure = "{\"height\":3,\"width\":6,\"x\":18,\"y\":1}"
      }

      layout_structure {
        key       = "panel8554BB5F8DC49A48"
        structure = "{\"height\":1,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panel8B5ADF0BA02A084E"
        structure = "{\"height\":5,\"width\":12,\"x\":12,\"y\":9,\"minHeight\":3,\"minWidth\":3}"
      }

      layout_structure {
        key       = "panelAA1E3CF486F17A4E"
        structure = "{\"height\":5,\"width\":6,\"x\":6,\"y\":4}"
      }

      layout_structure {
        key       = "panelACA79D7A9300FB41"
        structure = "{\"height\":3,\"width\":6,\"x\":12,\"y\":1}"
      }

      layout_structure {
        key       = "panelCA5A7CC0BDC86949"
        structure = "{\"height\":5,\"width\":6,\"x\":12,\"y\":4}"
      }

      layout_structure {
        key       = "panelCFD59AB9A8EA884C"
        structure = "{\"height\":3,\"width\":6,\"x\":6,\"y\":1}"
      }

      layout_structure {
        key       = "panelD73BD373953E8840"
        structure = "{\"height\":3,\"width\":6,\"x\":0,\"y\":1}"
      }

      layout_structure {
        key       = "panelDE5D9686AAD0D94C"
        structure = "{\"height\":5,\"width\":12,\"x\":0,\"y\":14}"
      }

      layout_structure {
        key       = "panelEC948CAFAD41C844"
        structure = "{\"height\":5,\"width\":12,\"x\":12,\"y\":9}"
      }

      layout_structure {
        key       = "panelPANE-2AA602CFA79BD949"
        structure = "{\"height\":1,\"width\":12,\"x\":0,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel064B942B858D0B40"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"threat_list_name\" \"flow_count\" \"reputation\" \"bytes_in\" \"bytes_out\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"threat_list_name\",\"flow_count\",\"reputation\",\"bytes_in\",\"bytes_out\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"inbound\" and action=\"A\" \n| concat(reputation, \" (\", threat_list_name, \")\") as Threat \n| concat(src_ip,\" - \", dest_ip) as host_pair \n| sum(flow_count) as Flows, sum(bytes_out) as Bytes_Sent, sum(bytes_in) as Bytes_Rcvd by host_pair, Threat \n| sort -Flows \n| limit 10"
        query_type   = "Logs"
      }

      title           = "Inbound Accepted"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"Flows\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"hideLabels\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel093F76E58725AB4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"threat_list_name\" \"flow_count\" \"reputation\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"threat_list_name\",\"flow_count\",\"reputation\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"inbound\" and action=\"A\" \n| concat(reputation, \" (\", threat_list_name, \")\") as Threat \n| timeslice 5m \n| sum(flow_count) as Flows by _timeslice, Threat \n| transpose row _timeslice column Threat"
        query_type   = "Logs"
      }

      title           = "Inbound Accepted"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"circle\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"Flows\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"hideLabels\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel1A81D2EC8F1EEB4D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"threat_list_name\" \"flow_count\" \"reputation\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"threat_list_name\",\"flow_count\",\"reputation\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"outbound\" and action=\"R\" \n| concat(reputation, \" (\", threat_list_name, \")\") as Threat \n| timeslice 5m \n| sum(flow_count) as Flows by _timeslice, Threat \n| transpose row _timeslice column Threat"
        query_type   = "Logs"
      }

      title           = "Outbound Rejected"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"circle\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"Flows\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"hideLabels\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8221D14D8C0D484C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"threat_list_name\" \"flow_count\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"threat_list_name\",\"flow_count\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"outbound\" and action=\"R\" \n| sum(flow_count) as Flows"
        query_type   = "Logs"
      }

      title           = "Outbound Rejected"
      visual_settings = "{\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"label\":\"Flows\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":0,\"valueFontSize\":32,\"labelFontSize\":20,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false}},\"series\":{},\"title\":{\"fontSize\":14}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8B5ADF0BA02A084E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"threat_list_name\" \"flow_count\" \"reputation\" \"bytes_in\" \"bytes_out\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"threat_list_name\",\"flow_count\",\"reputation\",\"bytes_in\",\"bytes_out\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"outbound\" and action=\"R\" \n| concat(reputation, \" (\", threat_list_name, \")\") as Threat \n| concat(src_ip,\" - \", dest_ip) as host_pair \n| sum(flow_count) as Flows, sum(bytes_out) as Bytes_Sent, sum(bytes_in) as Bytes_Rcvd by host_pair, Threat \n| sort -Flows \n| limit 10"
        query_type   = "Logs"
      }

      title           = "Outbound Rejected"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"Flows\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"hideLabels\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelAA1E3CF486F17A4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"threat_list_name\" \"flow_count\" \"reputation\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"threat_list_name\",\"flow_count\",\"reputation\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"outbound\" and action=\"A\" \n| concat(reputation, \" (\", threat_list_name, \")\") as Threat \n| timeslice 5m \n| sum(flow_count) as Flows by _timeslice, Threat \n| transpose row _timeslice column Threat"
        query_type   = "Logs"
      }

      title           = "Outbound Accepted"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"circle\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"Flows\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"hideLabels\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelACA79D7A9300FB41"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"threat_list_name\" \"flow_count\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"threat_list_name\",\"flow_count\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"inbound\" and action=\"R\" \n| sum(flow_count) as Flows"
        query_type   = "Logs"
      }

      title           = "Inbound Rejected"
      visual_settings = "{\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"label\":\"Flows\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":0,\"valueFontSize\":32,\"labelFontSize\":20,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false}},\"series\":{},\"title\":{\"fontSize\":14}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelCA5A7CC0BDC86949"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"threat_list_name\" \"reputation\" \"flow_count\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"threat_list_name\",\"reputation\",\"flow_count\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\"  \n| where direction=\"inbound\" and action=\"R\" \n| concat(reputation, \" (\", threat_list_name, \")\") as Threat \n| timeslice 5m \n| sum(flow_count) as Flows by _timeslice, Threat \n| transpose row _timeslice column Threat"
        query_type   = "Logs"
      }

      title           = "Inbound Rejected"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"circle\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"Flows\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"hideLabels\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelCFD59AB9A8EA884C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"threat_list_name\" \"flow_count\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"threat_list_name\",\"flow_count\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"outbound\" and action=\"A\" \n| sum(flow_count) as Flows"
        query_type   = "Logs"
      }

      title           = "Outbound Accepted"
      visual_settings = "{\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"label\":\"Flows\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":0,\"valueFontSize\":32,\"labelFontSize\":20,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false}},\"series\":{},\"title\":{\"fontSize\":14}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelD73BD373953E8840"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"threat_list_name\" \"flow_count\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"threat_list_name\",\"flow_count\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where  direction=\"inbound\" and action=\"A\" \n| sum(flow_count) as Flows"
        query_type   = "Logs"
      }

      title           = "Inbound Accepted"
      visual_settings = "{\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"label\":\"Flows\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":0,\"valueFontSize\":32,\"labelFontSize\":20,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false}},\"series\":{},\"title\":{\"fontSize\":14}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelDE5D9686AAD0D94C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"threat_list_name\" \"flow_count\" \"reputation\" \"bytes_in\" \"bytes_out\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"threat_list_name\",\"flow_count\",\"reputation\",\"bytes_in\",\"bytes_out\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"outbound\" and action=\"A\" \n| concat(reputation, \" (\", threat_list_name, \")\") as Threat \n| concat(src_ip,\" - \", dest_ip) as host_pair \n| sum(flow_count) as Flows, sum(bytes_out) as Bytes_Sent, sum(bytes_in) as Bytes_Rcvd  by host_pair, Threat \n| sort -Flows \n| limit 10"
        query_type   = "Logs"
      }

      title           = "Outbound Accepted"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"Flows\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"hideLabels\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelEC948CAFAD41C844"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"threat_list_name\" \"flow_count\" \"reputation\" \"bytes_in\" \"bytes_out\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"threat_list_name\",\"flow_count\",\"reputation\",\"bytes_in\",\"bytes_out\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"inbound\" and action=\"R\" \n| concat(reputation, \" (\", threat_list_name, \")\") as Threat \n| concat(src_ip,\" - \", dest_ip) as host_pair \n| sum(flow_count) as Flows, sum(bytes_out) as Bytes_Sent, sum(bytes_in) as Bytes_Rcvd by host_pair, Threat \n| sort -Flows \n| limit 10"
        query_type   = "Logs"
      }

      title           = "Inbound Rejected"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"Flows\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"hideLabels\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8554BB5F8DC49A48"
      title                                       = "Communications with Malicious Hosts - Rejected"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"text\":{\"format\":\"markdownV2\",\"horizontalAlignment\":\"left\",\"backgroundColor\":\"#066180\",\"textColor\":\"white\",\"verticalAlignment\":\"top\"},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-2AA602CFA79BD949"
      title                                       = "Communications with Malicious Hosts - Accepted"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"text\":{\"format\":\"markdownV2\",\"horizontalAlignment\":\"left\",\"backgroundColor\":\"#066180\",\"textColor\":\"white\",\"verticalAlignment\":\"top\"},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  refresh_interval = "0"
  theme            = "Dark"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1h"
        }
      }
    }
  }

  title = "NetFlow - Security Monitoring - Communications with Malicious Hosts"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "dest_ip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "dest_ip"

    source_definition {
      log_query_variable_source_definition {
        field = "dest_ip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"dest_ip\" \"nfc_id\" \n| json \"dest_ip\",\"nfc_id\" \n| where nfc_id=20062 \n| fields dest_ip"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "dest_port"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "dest_port"

    source_definition {
      log_query_variable_source_definition {
        field = "dest_port"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"dest_port\" \"nfc_id\" \n| json \"dest_port\",\"nfc_id\" \n| where nfc_id=20062 \n| fields dest_port"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "exp_ip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "exp_ip"

    source_definition {
      log_query_variable_source_definition {
        field = "exp_ip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"exp_ip\" \"nfc_id\" \n| json \"exp_ip\",\"nfc_id\" \n| where nfc_id=20062 \n| fields exp_ip"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "nfo_hostname"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "nfo_hostname"

    source_definition {
      log_query_variable_source_definition {
        field = "nfo_hostname"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfo_hostname\" \"nfc_id\" \n| json \"nfo_hostname\",\"nfc_id\" \n| where nfc_id=20062 \n| fields nfo_hostname"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "protocol"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "protocol"

    source_definition {
      log_query_variable_source_definition {
        field = "protocol"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"protocol\" \"nfc_id\" \n| json \"protocol\",\"nfc_id\" \n| where nfc_id=20062 \n| fields protocol"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "src_ip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "src_ip"

    source_definition {
      log_query_variable_source_definition {
        field = "src_ip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"src_ip\" \"nfc_id\" \n| json \"src_ip\",\"nfc_id\" \n| where nfc_id=20062 \n| fields src_ip"
      }
    }
  }
}

resource "sumologic_dashboard" "net_flow_security_monitoring_traffic_using_critical_ports" {
  description = "Dashboard showing analytics for your DNS traffic as well as critical port usage."
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
        key       = "panel10C88979B3215942"
        structure = "{\"height\":1,\"width\":24,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panel3568A5E39E7F2848"
        structure = "{\"height\":9,\"width\":8,\"x\":0,\"y\":11}"
      }

      layout_structure {
        key       = "panel6BDB306D9A32494C"
        structure = "{\"height\":1,\"width\":24,\"x\":0,\"y\":10}"
      }

      layout_structure {
        key       = "panel72A4A9D693710841"
        structure = "{\"height\":9,\"width\":8,\"x\":16,\"y\":1}"
      }

      layout_structure {
        key       = "panel7663F2C9B8CEC844"
        structure = "{\"height\":9,\"width\":8,\"x\":8,\"y\":11}"
      }

      layout_structure {
        key       = "panelA7D94295A46AA943"
        structure = "{\"height\":9,\"width\":8,\"x\":0,\"y\":1}"
      }

      layout_structure {
        key       = "panelC573E8EF9F5C1A4E"
        structure = "{\"height\":9,\"width\":8,\"x\":16,\"y\":11}"
      }

      layout_structure {
        key       = "panelDF26C19DBB6D7946"
        structure = "{\"height\":9,\"width\":8,\"x\":8,\"y\":1}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel3568A5E39E7F2848"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"flow_count\" \"bytes_in\" \"bytes_out\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"flow_count\",\"bytes_in\",\"bytes_out\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where action=\"A\" and direction=\"outbound\" and lookupContains(https://sumologicnetflow.s3.eu-central-1.amazonaws.com/critical_ports.csv,dest_port=dest_port) \n| lookup service from https://sumologicnetflow.s3.eu-central-1.amazonaws.com/critical_ports.csv on dest_port \n| concat(src_ip,\" - \", dest_ip, \":\", dest_port, \" (\", service, \")\") as Host_Pair  \n| sum(bytes_out) as Bytes_Sent, sum(bytes_in) as Bytes_Rcvd, sum(flow_count) as Flows by Host_Pair \n| sort by -Bytes_Sent \n| Limit 10 "
        query_type   = "Logs"
      }

      title           = "Top Outboound Traffic Accepted"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Source IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel72A4A9D693710841"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"flow_count\" \"bytes_in\" \"bytes_out\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"flow_count\",\"bytes_in\",\"bytes_out\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where action=\"A\" and dest_port=53 and direction=\"internal\" \n| concat(src_ip,\" - \", dest_ip) as Host_Pair  \n| sum(bytes_out) as Bytes_Sent, sum(bytes_in) as Bytes_Rcvd, sum(flow_count) as Flows by Host_Pair \n| sort by -Bytes_Sent \n| Limit 10 "
        query_type   = "Logs"
      }

      title           = "Top Internal DNS Traffic Accepted"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Source IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel7663F2C9B8CEC844"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"flow_count\" \"bytes_in\" \"bytes_out\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"flow_count\",\"bytes_in\",\"bytes_out\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where action=\"A\" and direction=\"inbound\" and lookupContains(https://sumologicnetflow.s3.eu-central-1.amazonaws.com/critical_ports.csv,dest_port=dest_port) \n| lookup service from https://sumologicnetflow.s3.eu-central-1.amazonaws.com/critical_ports.csv on dest_port \n| concat(src_ip,\" - \", dest_ip, \":\", dest_port, \" (\", service, \")\") as Host_Pair  \n| sum(bytes_out) as Bytes_Sent, sum(bytes_in) as Bytes_Rcvd, sum(flow_count) as Flows by Host_Pair \n| sort by -Bytes_Sent \n| Limit 10 "
        query_type   = "Logs"
      }

      title           = "Top Inboound Traffic Accepted "
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Source IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelA7D94295A46AA943"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"flow_count\" \"bytes_in\" \"bytes_out\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"flow_count\",\"bytes_in\",\"bytes_out\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where action=\"A\" and dest_port=53 and direction=\"outbound\" \n| concat(src_ip,\" - \", dest_ip) as Host_Pair  \n| sum(bytes_out) as Bytes_Sent, sum(bytes_in) as Bytes_Rcvd, sum(flow_count) as Flows by Host_Pair \n| sort by -Bytes_Sent \n| Limit 10 "
        query_type   = "Logs"
      }

      title           = "Top Outboound DNS Traffic Accepted "
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Source IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelC573E8EF9F5C1A4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"flow_count\" \"bytes_in\" \"bytes_out\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"flow_count\",\"bytes_in\",\"bytes_out\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where action=\"A\" and direction=\"internal\" and lookupContains(https://sumologicnetflow.s3.eu-central-1.amazonaws.com/critical_ports.csv,dest_port=dest_port) \n| lookup service from https://sumologicnetflow.s3.eu-central-1.amazonaws.com/critical_ports.csv on dest_port \n| concat(src_ip,\" - \", dest_ip, \":\", dest_port, \" (\", service, \")\") as Host_Pair  \n| sum(bytes_out) as Bytes_Sent, sum(bytes_in) as Bytes_Rcvd, sum(flow_count) as Flows by Host_Pair \n| sort by -Bytes_Sent \n| Limit 10 "
        query_type   = "Logs"
      }

      title           = "Top Internal Traffic Accepted "
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Source IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelDF26C19DBB6D7946"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"action\" \"direction\" \"flow_count\" \"bytes_in\" \"bytes_out\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"action\",\"direction\",\"flow_count\",\"bytes_in\",\"bytes_out\"  \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where action=\"A\" and dest_port=53 and direction=\"inbound\" \n| concat(src_ip,\" - \", dest_ip) as Host_Pair  \n| sum(bytes_out) as Bytes_Sent, sum(bytes_in) as Bytes_Rcvd, sum(flow_count) as Flows by Host_Pair \n| sort by -Bytes_Sent \n| Limit 10 "
        query_type   = "Logs"
      }

      title           = "Top Inbound DNS Traffic Accepted"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Source IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[],\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel10C88979B3215942"
      title                                       = "DNS Traffic"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"text\":{\"format\":\"markdownV2\",\"horizontalAlignment\":\"center\",\"backgroundColor\":\"#066180\",\"textColor\":\"white\"},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel6BDB306D9A32494C"
      title                                       = "Traffic Using Critical Ports (critical_ports.csv, default = 21(ftp), 22(ssh), 23(telnet), 25(smtp), 50(re-mail-ck), 51(la-maint), 67(bootps), 68(bootpc), 115(sftp), 123(ntp), 137(netbios-ns), 138(netbios-dgm), 139(netbios-ssn), 445(microsoft-ds), 3389(ms-wbt-server)"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"text\":{\"format\":\"markdownV2\",\"horizontalAlignment\":\"center\",\"backgroundColor\":\"#066180\",\"textColor\":\"white\"},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  refresh_interval = "0"
  theme            = "Dark"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1h"
        }
      }
    }
  }

  title = "NetFlow - Security Monitoring - Traffic Using Critical Ports"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "dest_ip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "dest_ip"

    source_definition {
      log_query_variable_source_definition {
        field = "dest_ip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"dest_ip\" \"nfc_id\" \n| json \"dest_ip\",\"nfc_id\" \n| where nfc_id=20062 \n| fields dest_ip"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "dest_port"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "dest_port"

    source_definition {
      log_query_variable_source_definition {
        field = "dest_port"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"dest_port\" \"nfc_id\" \n| json \"dest_port\",\"nfc_id\" \n| where nfc_id=20062 \n| fields dest_port"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "exp_ip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "exp_ip"

    source_definition {
      log_query_variable_source_definition {
        field = "exp_ip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"exp_ip\" \"nfc_id\" \n| json \"exp_ip\",\"nfc_id\" \n| where nfc_id=20062 \n| fields exp_ip"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "nfo_hostname"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "nfo_hostname"

    source_definition {
      log_query_variable_source_definition {
        field = "nfo_hostname"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfo_hostname\" \"nfc_id\" \n| json \"nfo_hostname\",\"nfc_id\" \n| where nfc_id=20062 \n| fields nfo_hostname"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "protocol"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "protocol"

    source_definition {
      log_query_variable_source_definition {
        field = "protocol"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"protocol\" \"nfc_id\" \n| json \"protocol\",\"nfc_id\" \n| where nfc_id=20062 \n| fields protocol"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "src_ip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "src_ip"

    source_definition {
      log_query_variable_source_definition {
        field = "src_ip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"src_ip\" \"nfc_id\" \n| json \"src_ip\",\"nfc_id\" \n| where nfc_id=20062 \n| fields src_ip"
      }
    }
  }
}

resource "sumologic_dashboard" "net_flow_traffic_overview" {
  description = "Dashboard monitoring network traffic by volume and host. It provides details for top senders, receivers, protocols, ports, applications, and users."
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
        key       = "panel05358E8DA830DB4A"
        structure = "{\"height\":7,\"width\":8,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panel2B35713985257A4B"
        structure = "{\"height\":7,\"width\":8,\"x\":16,\"y\":0}"
      }

      layout_structure {
        key       = "panel467B31D99F55A947"
        structure = "{\"height\":5,\"width\":8,\"x\":8,\"y\":7}"
      }

      layout_structure {
        key       = "panel9C85ADF3ABF8A847"
        structure = "{\"height\":7,\"width\":8,\"x\":8,\"y\":0}"
      }

      layout_structure {
        key       = "panelC6C79A749997BA4D"
        structure = "{\"height\":7,\"width\":8,\"x\":8,\"y\":12}"
      }

      layout_structure {
        key       = "panelCD51CBFA968C9A4D"
        structure = "{\"height\":7,\"width\":8,\"x\":16,\"y\":12}"
      }

      layout_structure {
        key       = "panelD73BD373953E8840"
        structure = "{\"height\":5,\"width\":8,\"x\":0,\"y\":7}"
      }

      layout_structure {
        key       = "panelDF26C19DBB6D7946"
        structure = "{\"height\":7,\"width\":8,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelE900300EB7813B4D"
        structure = "{\"height\":5,\"width\":8,\"x\":16,\"y\":7}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel05358E8DA830DB4A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"bytes_in\"  \"bytes_out\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"bytes_in\",\"bytes_out\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| bytes_in + bytes_out as bytes \n| lookup transport from https://sumologicnetflow.s3.eu-central-1.amazonaws.com/netflow_protocols.csv on protocol \n| concat(transport, \" (\",exp_ip,\") \") as transport \n| sum(bytes) as mb by transport \n| mb/1024/1024 as mb  \n| sort by -mb \n| Limit 10"
        query_type   = "Logs"
      }

      title           = "Top Traffic Protocols"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"title\":\"Protocol (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false,\"minimum\":0},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel2B35713985257A4B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"bytes_in\"  \"bytes_out\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"bytes_out\",\"bytes_in\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| bytes_in + bytes_out as bytes \n| concat(src_ip,\" - \", dest_ip) as host_pair  \n| sum(bytes) as mb by host_pair \n| mb/1024/1024 as mb  \n| sort by -mb \n| Limit 10"
        query_type   = "Logs"
      }

      title           = "Top Traffic Conversations"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"title\":\"Client - Server\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false,\"minimum\":0},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel467B31D99F55A947"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"bytes_in\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"bytes_in\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"outbound\" \n| timeslice 5m \n| sum(bytes_in) as mb by _timeslice, nfo_hostname \n| mb/1024/1024 as mb  \n| transpose row _timeslice column nfo_hostname"
        query_type   = "Logs"
      }

      title           = "Traffic Outbound by NFO"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"Time\",\"titleFontSize\":12,\"labelFontSize\":12,\"hideLabels\":false},\"axisY\":{\"title\":\"MB\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"hideLabels\":false},\"axisY2\":{\"hideLabels\":true}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel9C85ADF3ABF8A847"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"bytes_out\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"bytes_in\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where nfc_id=20062\n| concat(dest_ip, \" (\",exp_ip,\") \") as destination_ip \n| sum(bytes_in) as mb by destination_ip \n| mb/1024/1024 as mb  \n| sort by -mb \n| Limit 10"
        query_type   = "Logs"
      }

      title           = "Top Traffic Receiving"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"title\":\"Destination IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false,\"minimum\":0},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelC6C79A749997BA4D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"bytes_in\"  \"bytes_out\"  \"20062\" \"app_name\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"bytes_in\",\"bytes_out\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| bytes_in + bytes_out as bytes \n| concat(app_name, \" (\",exp_ip,\") \") as app \n| sum(bytes) as mb by app \n| mb/1024/1024 as mb  \n| sort by -mb \n| Limit 10"
        query_type   = "Logs"
      }

      title           = "Top Traffic Applications"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"title\":\"Application (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false,\"minimum\":0},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelCD51CBFA968C9A4D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"bytes_in\"  \"bytes_out\"  \"20062\" \"username\" \n|  json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"bytes_in\",\"bytes_out\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| bytes_in + bytes_out as bytes \n| concat(username, \" (\",exp_ip,\") \") as username \n| sum(bytes) as mb by username \n| mb/1024/1024 as mb  \n| sort by -mb \n| Limit 10"
        query_type   = "Logs"
      }

      title           = "Top Traffic Users"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"title\":\"User (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false,\"minimum\":0},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelD73BD373953E8840"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"bytes_in\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"bytes_in\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\"  \n| where direction=\"inbound\" \n| timeslice 5m \n| sum(bytes_in) as mb by _timeslice, nfo_hostname \n| mb/1024/1024 as mb  \n| transpose row _timeslice column nfo_hostname"
        query_type   = "Logs"
      }

      title           = "Traffic Inbound by NFO"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"Time\",\"titleFontSize\":12,\"labelFontSize\":12,\"hideLabels\":false},\"axisY\":{\"title\":\"MB\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"hideLabels\":false},\"axisY2\":{\"hideLabels\":true}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":false,\"maxWidth\":140},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelDF26C19DBB6D7946"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"bytes_out\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"bytes_out\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| concat(src_ip, \" (\",exp_ip,\") \") as source_ip \n| sum(bytes_out) as mb by source_ip \n| mb/1024/1024 as mb  \n| sort by -mb \n| Limit 10"
        query_type   = "Logs"
      }

      title           = "Top Traffic Sending"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"showAsTable\":false,\"wrap\":true,\"maxWidth\":200},\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"title\":\"Source IP (Exporter)\",\"hideLabels\":false,\"titleFontSize\":9,\"labelFontSize\":9},\"axisY\":{\"title\":\"MBytes\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"gridThickness\":1,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":false,\"minimum\":0},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"titleFontFamily\":\"Lab Grotesque Medium, \\\"Arial Bold\\\", sans-serif\",\"titleFontColor\":\"#EBEFF2\",\"titleFontWeight\":\"normal\",\"labelFontColor\":\"#EBEFF2\",\"lineColor\":\"#DDE4E9\",\"stripLines\":null,\"lineThickness\":0,\"labelFontSize\":12,\"tickColor\":\"#344666\",\"logarithmic\":false,\"linear\":false,\"unit\":{\"value\":\"\",\"isCustom\":false},\"gridThickness\":0,\"valueFormatString\":\"\",\"gridColor\":\"#344666\",\"labelFontFamily\":\"Lab Grotesque Regular, \\\"Arial\\\", sans-serif\",\"labelFontWeight\":\"normal\",\"hideLabels\":true}},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelE900300EB7813B4D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfc_id\" \"exp_ip\" \"src_ip\" \"dest_ip\" \"dest_port\" \"protocol\" \"bytes_in\"  \"20062\" \n| json \"nfc_id\",\"exp_ip\",\"src_ip\",\"dest_ip\",\"dest_port\",\"protocol\",\"bytes_in\",\"bytes_out\" \n| where nfc_id=20062 AND nfo_hostname matches \"{{nfo_hostname}}\" AND exp_ip matches \"{{exp_ip}}\" AND src_ip matches \"{{src_ip}}\" AND dest_ip matches \"{{dest_ip}}\" AND dest_port matches \"{{dest_port}}\" AND protocol matches \"{{protocol}}\" \n| where direction=\"internal\" \n| timeslice 5m \n| bytes_in + bytes_out as bytes \n| sum(bytes) as mb by _timeslice, nfo_hostname \n| mb/1024/1024 as mb  \n| transpose row _timeslice column nfo_hostname"
        query_type   = "Logs"
      }

      title           = "Traffic Internal by NFO"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"Time\",\"titleFontSize\":12,\"labelFontSize\":12,\"hideLabels\":false},\"axisY\":{\"title\":\"MB\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"hideLabels\":false},\"axisY2\":{\"hideLabels\":true}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  refresh_interval = "0"
  theme            = "Dark"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1h"
        }
      }
    }
  }

  title = "NetFlow - Traffic Overview"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "dest_ip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "dest_ip"

    source_definition {
      log_query_variable_source_definition {
        field = "dest_ip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"dest_ip\" \"nfc_id\" \n| json \"dest_ip\",\"nfc_id\" \n| where nfc_id=20062 \n| fields dest_ip"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "dest_port"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "dest_port"

    source_definition {
      log_query_variable_source_definition {
        field = "dest_port"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"dest_port\" \"nfc_id\" \n| json \"dest_port\",\"nfc_id\" \n| where nfc_id=20062 \n| fields dest_port"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "exp_ip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "exp_ip"

    source_definition {
      log_query_variable_source_definition {
        field = "exp_ip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"exp_ip\" \"nfc_id\" \n| json \"exp_ip\",\"nfc_id\" \n| where nfc_id=20062 \n| fields exp_ip"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "nfo_hostname"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "nfo_hostname"

    source_definition {
      log_query_variable_source_definition {
        field = "nfo_hostname"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"nfo_hostname\" \"nfc_id\" \n| json \"nfo_hostname\",\"nfc_id\" \n| where nfc_id=20062 \n| fields nfo_hostname"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "protocol"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "protocol"

    source_definition {
      log_query_variable_source_definition {
        field = "protocol"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"protocol\" \"nfc_id\" \n| json \"protocol\",\"nfc_id\" \n| where nfc_id=20062 \n| fields protocol"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "src_ip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "src_ip"

    source_definition {
      log_query_variable_source_definition {
        field = "src_ip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"src_ip\" \"nfc_id\" \n| json \"src_ip\",\"nfc_id\" \n| where nfc_id=20062 \n| fields src_ip"
      }
    }
  }
}
