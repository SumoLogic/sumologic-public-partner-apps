resource "sumologic_dashboard" "nucleon" {
  description = "Nucleon learns about the external threat landscape in order to determine how threats can impact your security posture. Nucleon delivers notifications for pre-attack adversary behaviour, empowering you to truly protect your network. As part of its core functions, the Nucleon polymorphic sensors identify impending threats before impact, automating these early-warnings effectively. With our active threat feeds and robust client integrations, these all equal early threat detection and visibility, and increased protection. An additional set of these polymorphic sensors sit closer to the gateways of your network, collecting data about sensitive and vulnerable access points that are unique to your network specifically. They expand your attack surface in order to lure in and potentially trap those bad actors. We provide only actionable alerts, actively guiding you to block the attack source with the help of your existing defense systems. From the Nucleon dashboard, you can access threat intelligence assessments, threat alerts, insights and remediation guidance that contribute to a strengthened security posture. The process is described in detail. For any questions or concerns please contact us through your Slack channel or at Support@nucleon.sh"
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
        key       = "panel3CD4D7B4A6DFDA43"
        structure = "{\"height\":25,\"width\":10,\"x\":14,\"y\":15}"
      }

      layout_structure {
        key       = "panel421C6F5A8EAC884C"
        structure = "{\"height\":5,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panel8ABFB1C0A816DB4B"
        structure = "{\"height\":10,\"width\":8,\"x\":0,\"y\":5}"
      }

      layout_structure {
        key       = "panelA633EAD1887E5A43"
        structure = "{\"height\":10,\"width\":9,\"x\":15,\"y\":5}"
      }

      layout_structure {
        key       = "panelPANE-063D6583AF43BB45"
        structure = "{\"height\":5,\"width\":12,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-30762D199D38F844"
        structure = "{\"height\":25,\"width\":14,\"x\":0,\"y\":15}"
      }

      layout_structure {
        key       = "panelPANE-64F3C6BA93833942"
        structure = "{\"height\":10,\"width\":7,\"x\":8,\"y\":5}"
      }
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "The \"Malicious URL Count\" window displays the sum of malicious URLs received from threats. (Each threat has a list of malicious URLs). "
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel421C6F5A8EAC884C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"maliciousURLCount\" as malicious\n| sum (malicious)"
        query_type   = "Logs"
      }

      title           = "Malicious URL count"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"label\":\"Active Threats\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":true,\"rounding\":2,\"valueFontSize\":40,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":0,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false},\"gauge\":{\"show\":false,\"min\":0,\"max\":100}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "The \"Threats By Day\" window displays the number of threats per day relatively to the selected range."
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8ABFB1C0A816DB4B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"day\", \"ip\"\n| fields day, ip\n| count as ip_count by ip, day\n| sum (ip_count) as threatcount by day\n| sort by day\n| limit 8"
        query_type   = "Logs"
      }

      title           = "Threats by day"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Dark\"},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "The \"Threats By Source Country Bar\" window displays a bar chart showing the source country and the threats count relatively to the selected time range"
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel3CD4D7B4A6DFDA43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"ip\", \"sourceCountry\"\n| fields ip, sourceCountry\n| count as ip_count by ip, sourceCountry\n| sum (ip_count) as threatcount by sourceCountry\n| where sourceCountry != \"XX\"\n| sort by threatcount\n| limit 20\n"
        query_type   = "Logs"
      }

      title           = "Threats by source country bar"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"bar\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "The \"Threats By Source Country MAP\" window displays a map showing the source country and the threats count relatively to the selected time range"
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-30762D199D38F844"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"ip\" as ip_address\n| lookup latitude, longitude, country_code, country_name, region, city, postal_code from geo://location on ip = ip_address\n| count by latitude, longitude, country_code, country_name, region, city, postal_code\n| sort _count"
        query_type   = "Logs"
      }

      title           = "Threats by source country map"
      visual_settings = "{\"general\":{\"mode\":\"map\",\"type\":\"map\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "The \"Threats Count\" window displays the overall number of threats provided by nucleon, relative to the selected time range."
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-063D6583AF43BB45"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"ip\" as ip_address\n| count as ip_count by ip_address\n| sum (ip_count) as threat_count\n"
        query_type   = "Logs"
      }

      title           = "Threats count"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"label\":\"Active Threats\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":true,\"rounding\":2,\"valueFontSize\":40,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":0,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false},\"gauge\":{\"show\":false,\"min\":0,\"max\":100}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "The \"Threats by Segment\" window displays threats relatively to there segment (critical_infrastructure, energy, fintech, governments, health_care, municipality, general, telecom)"
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelA633EAD1887E5A43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"ip\" , \"segment\"\n| count by segment"
        query_type   = "Logs"
      }

      title           = "Threats by segment"
      visual_settings = "{\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":0.85,\"startAngle\":270,\"innerRadius\":\"55%\",\"maxNumOfSlices\":15,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{\"US\":{\"visible\":true},\"Others\":{\"visible\":false},\"HK\":{\"visible\":false},\"BR\":{\"visible\":false}},\"legend\":{\"enabled\":true,\"fontSize\":15,\"wrap\":false},\"color\":{\"family\":\"Colorsafe\"},\"title\":{\"fontSize\":14}}"
    }
  }

  panel {
    sumo_search_panel {
      description                                 = "The \"Threats by Source Country\" window displays threats by the top source countries.  "
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-64F3C6BA93833942"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"sourceCountry\"\n| where sourceCountry != \"XX\"\n| where sourceCountry != \"HK\"\n| count by sourceCountry\n// | where _count > 50\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Threats by source country"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":0.85,\"startAngle\":270,\"innerRadius\":\"55%\",\"maxNumOfSlices\":8,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{\"US\":{\"visible\":true},\"Others\":{\"visible\":false},\"HK\":{\"visible\":false},\"BR\":{\"visible\":false}},\"legend\":{\"enabled\":true,\"fontSize\":15},\"color\":{\"family\":\"Colorsafe\"}}"
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

  title = "Nucleon"
}
