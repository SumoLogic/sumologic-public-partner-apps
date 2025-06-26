resource "sumologic_dashboard" "application_insights_overview" {
  description = "The Application Insights Dashboard delivers a holistic view of application behavior and network performance across your environment. It features a timeline view of selected protocols, allowing users to narrow down the analysis based on specific time windows, which is particularly useful for identifying and correlating performance issues or unusual activity."
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
        key       = "panel14FDAB9EAEFA6A4B"
        structure = "{\"height\":8,\"width\":12,\"x\":12,\"y\":32}"
      }

      layout_structure {
        key       = "panel6A04F39DB464AB44"
        structure = "{\"height\":9,\"width\":12,\"x\":12,\"y\":17}"
      }

      layout_structure {
        key       = "panel8A8959EAAB922A4A"
        structure = "{\"height\":9,\"width\":12,\"x\":0,\"y\":17}"
      }

      layout_structure {
        key       = "panel90E2509C86AF9841"
        structure = "{\"height\":8,\"width\":12,\"x\":0,\"y\":9}"
      }

      layout_structure {
        key       = "panel91288E9FA5F8CA45"
        structure = "{\"height\":14,\"width\":12,\"x\":12,\"y\":3}"
      }

      layout_structure {
        key       = "panelPANE-186317C4A4860B4C"
        structure = "{\"height\":8,\"width\":12,\"x\":12,\"y\":40}"
      }

      layout_structure {
        key       = "panelPANE-335C9821BDDB6844"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":26}"
      }

      layout_structure {
        key       = "panelPANE-869958E1BC5F6841"
        structure = "{\"height\":8,\"width\":12,\"x\":0,\"y\":40}"
      }

      layout_structure {
        key       = "panelPANE-A227F0A785356941"
        structure = "{\"height\":8,\"width\":12,\"x\":0,\"y\":32}"
      }

      layout_structure {
        key       = "panelPANE-C7E23C2D901EBA42"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":3}"
      }

      layout_structure {
        key       = "panelPANE-C8F1F1518CBCCB47"
        structure = "{\"height\":3,\"width\":24,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-F88832FDA5953844"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":26}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel14FDAB9EAEFA6A4B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(http_code)\n| count by http_code | sort by _count"
        query_type   = "Logs"
      }

      time_range {
        begin_bounded_time_range {
          from {
            relative_time_range {
              relative_time = "-1d"
            }
          }
        }
      }

      title           = "HTTP Response Codes"
      visual_settings = "{\"series\":{},\"overrides\":[],\"general\":{\"type\":\"funnel\",\"displayType\":\"default\",\"roundDataPoints\":true,\"maxNumOfSlices\":10,\"indexLabelFontSize\":14,\"orientation\":\"default\",\"valueRepresents\":\"height\",\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel6A04F39DB464AB44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(ssl_validity_not_before)\n| count by ssl_validity_not_before,ssl_validity_not_after,ssl_issuer,ssl_common_name,src_ip,dst_ip\n| sort by ssl_validity_not_before asc"
        query_type   = "Logs"
      }

      title           = "Expired TLS Certificates"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8A8959EAAB922A4A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(ssl_cipher_suite_id) \n| count by ssl_cipher_suite_id"
        query_type   = "Logs"
      }

      title           = "SSL Ciphers in Use"
      visual_settings = "{\"series\":{},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel90E2509C86AF9841"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(dns_query)\n| count by dns_query\n| sort by _count\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 DNS Queries"
      visual_settings = "{\"series\":{},\"general\":{\"type\":\"funnel\",\"displayType\":\"default\",\"roundDataPoints\":true,\"maxNumOfSlices\":10,\"indexLabelFontSize\":14,\"orientation\":\"default\",\"valueRepresents\":\"height\",\"mode\":\"distribution\"},\"xy\":{\"xDimension\":[],\"yDimension\":[],\"zDimension\":[]}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel91288E9FA5F8CA45"







      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json field=element \"app_name\" as app_name\n| count by app_name"
        query_type   = "Logs"
      }

      title           = "Application Overview"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"innerRadius\":\"50%\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-186317C4A4860B4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(dns_query)\n| count by src_ip "
        query_type   = "Logs"
      }

      title           = "Top DNS Queries"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-335C9821BDDB6844"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(ssl_protocol_version)\n| count as count by ssl_protocol_version\n| sort by count"
        query_type   = "Logs"
      }

      title           = "TLS info"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"noDataMessage\":\"\"},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-869958E1BC5F6841"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(app_name) and app_name!=\"0\" and app_name!=\"unknown\"\n| where !isNull(http_rtt) and http_rtt!=\"\"\n| avg(http_rtt) by app_name\n| limit 12\n"
        query_type   = "Logs"
      }

      title           = "Top 12 Applications with most response time (in seconds)"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"distribution\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-A227F0A785356941"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(http_code) and http_code >= 400\n| timeslice 1m\n| count by http_code, _timeslice\n| formatDate(_timeslice, \"HH:mm\") as Time\n| sort by Time\n\n"
        query_type   = "Logs"
      }

      title           = "Distribution of HTTP Client Error Codes"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"color\":{\"family\":\"Categorical Default\"},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"distribution\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-C7E23C2D901EBA42"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"*ssh*\" OR app_name matches \"*rdp *\" OR app_name matches \"*telnet*\" OR app_name matches \"*http*\"  OR app_name matches \"*dns*\"  OR app_name matches \"*krb5*\"  OR app_name matches \"*smb*\"  OR app_name matches \"*dhcp*\"  OR app_name matches \"*https*\" OR app_name matches \"*smtp*\" OR app_name matches \"*imap*\" OR app_name matches \"*pop3*\"\n| (src_bytes + dst_bytes) as total_bytes\n| count by app_name,total_bytes\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Timeline View of Selected Protocols"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Diverging 1\"},\"series\":{},\"general\":{\"type\":\"area\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"circle\",\"lineThickness\":1,\"fillOpacity\":0.25,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-F88832FDA5953844"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(dst_ip)\n| where app_name = \"dns\" \u0026\u0026 dst_port=53 \n| count by dst_ip\n| sort by _count\n| limit 25"
        query_type   = "Logs"
      }

      title           = "DNS Servers"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-C8F1F1518CBCCB47"
      text                                        = "The Application Insights Dashboard helps customers proactively monitor application health, performance, and security. By correlating protocol activity, TLS status, DNS behavior, and error trends, it enables faster troubleshooting and root cause analysis. This visibility empowers teams to optimize underperforming applications and ensure a secure, seamless user experience."
      title                                       = "Overivew of Applications Insights "
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"text\":{\"format\":\"markdownV2\",\"fontSize\":15,\"textColor\":\"#007ca6\"},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "Application Insights- Overview"
}

resource "sumologic_dashboard" "dev_ops_api_inventory_and_network_insights" {
  description = "This Dashboard helps to represent API inventory details like API versions and Their network insights"
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
        key       = "panel6A04F39DB464AB44"
        structure = "{\"height\":9,\"width\":12,\"x\":12,\"y\":3}"
      }

      layout_structure {
        key       = "panel91288E9FA5F8CA45"
        structure = "{\"height\":14,\"width\":12,\"x\":0,\"y\":3}"
      }

      layout_structure {
        key       = "panelPANE-15CA3EAAAB147949"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":30}"
      }

      layout_structure {
        key       = "panelPANE-3643D79CB93BDA47"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":48}"
      }

      layout_structure {
        key       = "panelPANE-5B04C02EB5BA4B49"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":42}"
      }

      layout_structure {
        key       = "panelPANE-6292F6AE92754A4C"
        structure = "{\"height\":5,\"width\":24,\"x\":0,\"y\":37}"
      }

      layout_structure {
        key       = "panelPANE-67068F0291B9FB4A"
        structure = "{\"height\":7,\"width\":24,\"x\":0,\"y\":54}"
      }

      layout_structure {
        key       = "panelPANE-841DC2FCB39E094F"
        structure = "{\"height\":1,\"width\":24,\"x\":0,\"y\":36}"
      }

      layout_structure {
        key       = "panelPANE-8AB90985852ABA48"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-AE691376B6515B44"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":24}"
      }

      layout_structure {
        key       = "panelPANE-B38EAF20A17D0B48"
        structure = "{\"height\":7,\"width\":12,\"x\":0,\"y\":29}"
      }

      layout_structure {
        key       = "panelPANE-B6460008BC25284A"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":17}"
      }

      layout_structure {
        key       = "panelPANE-BB1936839851A94D"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":18}"
      }

      layout_structure {
        key       = "panelPANE-C8F1F1518CBCCB47"
        structure = "{\"height\":3,\"width\":24,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-CDF5CD22B76FAA48"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":23}"
      }

      layout_structure {
        key       = "panelPANE-ED285348A511BA4A"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":48}"
      }

      layout_structure {
        key       = "panelPANE-FADF64AF9847F941"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":42}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel6A04F39DB464AB44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(app_name) and http_uri_path matches \"*v1*\"\n| count by http_uri_path\n| sort by _count desc\n| limit 10"
        query_type   = "Logs"
      }

      title           = "API with V1"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel91288E9FA5F8CA45"







      query {
        query_key    = "A"
        query_string = "\n_sourceCategory= Gigamon\n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(app_name)\n| count as count by http_uri_path\n| sort by count"
        query_type   = "Logs"
      }

      title           = "Total API over the Enterprise"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"innerRadius\":\"50%\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-15CA3EAAAB147949"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(app_name) and http_uri_path matches \"*v3*\"\n| count by dst_ip, http_uri_path\n| limit 10\n"
        query_type   = "Logs"
      }

      title           = "API with V3"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-3643D79CB93BDA47"

      query {
        query_key    = "A"
        query_string = "\n_sourceCategory= Gigamon\n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json field=element \"end_reason\" as end_reason\n| count by end_reason\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Flow End Reason"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-5B04C02EB5BA4B49"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| (src_bytes + dst_bytes) as total_bytes\n| count by dst_ip,total_bytes\n| limit 10\n\n\n"
        query_type   = "Logs"
      }

      title           = "Top Destinations"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-6292F6AE92754A4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| (src_bytes + dst_bytes) as total_bytes\n| count by app_name,total_bytes\n| limit 10\n\n"
        query_type   = "Logs"
      }

      title           = "Application Trend by Bandwidth"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"area\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"fillOpacity\":0.25,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-67068F0291B9FB4A"

      query {
        query_key    = "A"
        query_string = "\n_sourceCategory= Gigamon\n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(app_name) \n| where app_name == \"*realvnc*\" OR app_name == \"*teamviewer*\" OR app_name == \"*ssh*\" OR app_name == \"*rdp*\" OR app_name == \"*anydesk*\"\n| count by app_name\n\n"
        query_type   = "Logs"
      }

      title           = "Top Remote Applications"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-8AB90985852ABA48"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(app_name) and http_uri_path matches \"*v2*\"\n| count by http_uri_path\n| sort by _count desc\n| limit 10"
        query_type   = "Logs"
      }

      title           = "API with V2"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-AE691376B6515B44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(app_name) and http_uri_path matches \"*v1*\"\n| count by dst_ip, http_uri_path\n| limit 10\n"
        query_type   = "Logs"
      }

      title           = "API With V1"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-B38EAF20A17D0B48"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(app_name) and http_uri_path matches \"*v2*\"\n| count by dst_ip, http_uri_path\n| limit 10\n"
        query_type   = "Logs"
      }

      title           = "API with V2"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-B6460008BC25284A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(app_name) and http_uri_path matches \"*v3*\"\n| count by http_uri_path\n| sort by _count desc\n| limit 10"
        query_type   = "Logs"
      }

      title           = "API with V3"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-BB1936839851A94D"

      query {
        query_key    = "A"
        query_string = "\n_sourceCategory= Gigamon\n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(http_method)\n| count as count by http_method\n| sort by count"
        query_type   = "Logs"
      }

      title           = "Top HTTP Methods"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-CDF5CD22B76FAA48"

      query {
        query_key    = "A"
        query_string = "\n_sourceCategory= Gigamon\n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(http_server_agent)\n| count as count by http_server_agent\n| sort by count"
        query_type   = "Logs"
      }

      title           = "HTTP Server Agent"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-ED285348A511BA4A"

      query {
        query_key    = "A"
        query_string = "\n\n_sourceCategory= Gigamon\n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json field=element \"app_name\" as app_name\n| where !isNull(app_name) and app_name!=\"Classification-unknown\" and !isNull(TcpRttMax)\n| avg(TcpRttMax) as TcpRttMax\n| count by TcpRttMax\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Average TCP Latency"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"area\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"fillOpacity\":0.25,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-FADF64AF9847F941"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| (src_bytes + dst_bytes) as total_bytes\n| count by src_ip,total_bytes\n| limit 10\n\n\n"
        query_type   = "Logs"
      }

      title           = "Top 10 Sources"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-841DC2FCB39E094F"
      title                                       = "NETWORK INSIGHTS"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"text\":{\"format\":\"markdownV2\"},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-C8F1F1518CBCCB47"
      text                                        = "This dashboard represents the API version details"
      title                                       = "Overivew of API Inventory"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"text\":{\"format\":\"markdownV2\",\"fontSize\":15,\"textColor\":\"#007ca6\"},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "DevOps - API Inventory and Network Insights"
}

resource "sumologic_dashboard" "hippa_network_compliance_evaluation" {
  description = "This dashboards provides HIPPA network compliance related details like Top 10 worst performing servers, server latency and DNS details"
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
        key       = "panelPANE-2F534FB69F6EDB4A"
        structure = "{\"height\":8,\"width\":24,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-5AFEA23B9F890849"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":14,\"minHeight\":3,\"minWidth\":3}"
      }

      layout_structure {
        key       = "panelPANE-73BCFB6FA66A3A43"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":8}"
      }

      layout_structure {
        key       = "panelPANE-809E7F09B20F5841"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":8}"
      }

      layout_structure {
        key       = "panelPANE-E210F29F97591A4E"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":14,\"minHeight\":3,\"minWidth\":3}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-2F534FB69F6EDB4A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(tcp_rtt_app) and tcp_rtt_app > 2\n| where app_name != \"Classification-unknown\" and app_name != \"Unknown tcp\" and app_name != \"Unknown udp\" and app_name != \"Unknown ssl\" and app_name != \"\"\n| avg(tcp_rtt_app) as Server_Latency by dst_ip\n| sort by Server_Latency desc\n| limit 10\n"
        query_type   = "Logs"
      }

      title           = "Top 10 worst performing Servers"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Light\"},\"series\":{},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-5AFEA23B9F890849"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where dns_host_addr != \"\" and src_ip != \"\" and dst_ip != \"\"\n| concat(dns_name, \";\", dns_host_addr) as dns_pair\n| dedup dns_pair\n| count by dns_name, dns_host_addr, src_ip, dst_ip, dns_ttl, dns_response_time\n| sort by dns_name\n"
        query_type   = "Logs"
      }

      title           = "DNS Query and Name Resolution"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-73BCFB6FA66A3A43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name!=\"Unknown tcp\" \n  \u0026\u0026 app_name!=\"Unknown udp\" \n  \u0026\u0026 app_name!=\"Unknown ssl\" \n  \u0026\u0026 app_name!=\"Classification-unknown\" \n  \u0026\u0026 app_name!=\"\" \n  \u0026\u0026 tcp_rtt!=\"\"\n| src_ip as Client\n| dst_ip as Server\n| app_name as Application_Name\n| count by Client, Server, Application_Name, tcp_rtt\n\n"
        query_type   = "Logs"
      }

      title           = "Network Latency"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-809E7F09B20F5841"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name!=\"Unknown tcp\" \n  \u0026\u0026 app_name!=\"Unknown udp\" \n  \u0026\u0026 app_name!=\"Unknown ssl\" \n  \u0026\u0026 app_name!=\"Classification-unknown\" \n  \u0026\u0026 app_name!=\"\" \n  \u0026\u0026 tcp_rtt_app>2\n| count by src_ip, dst_ip, app_name, tcp_rtt_app\n"
        query_type   = "Logs"
      }

      title           = "Server Latency"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-E210F29F97591A4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(dns_reply_code)\n| if(dns_reply_code == \"0\", \"NOERROR\",\n  if(dns_reply_code == \"1\", \"FORMERR\",\n  if(dns_reply_code == \"2\", \"SERVFAIL\",\n  if(dns_reply_code == \"3\", \"NXDOMAIN\",\n  if(dns_reply_code == \"4\", \"NOTIMP\",\n  if(dns_reply_code == \"5\", \"REFUSED\", \n  if(dns_reply_code == \"6\", \"Name Exists when it should not\",\n  if(dns_reply_code == \"7\", \"RR Set Exists when it should not\",\n  if(dns_reply_code == \"8\", \"RR Set that should exist does not\",\n  if(dns_reply_code == \"9\", \"Not Authorized\",\n  if(dns_reply_code == \"10\", \"Name not contained in zone\",\n  if(dns_reply_code == \"11\", \"DSO-TYPE Not Implemented\",\n  if(dns_reply_code == \"16\", \"Bad OPT Version\",\n  if(dns_reply_code == \"17\", \"Key not recognized\",\n  if(dns_reply_code == \"18\", \"Signature out of time window\",\n  if(dns_reply_code == \"19\", \"Bad TKEY Mode\",\n  if(dns_reply_code == \"20\", \"Duplicate key name\",\n  if(dns_reply_code == \"21\", \"Algorithm not supported\",\n  if(dns_reply_code == \"22\", \"Bad Truncation\",\n  if(dns_reply_code == \"23\", \"Bad/missing Server Cookie\",\n    dns_reply_code)))))))))))))))))))) as reply_code\n| where reply_code != \"\"\n| count by reply_code, src_ip, dst_ip\n| sum(_count) as ccount by reply_code\n| sort by ccount desc"
        query_type   = "Logs"
      }

      title           = "DNS Reply Type"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "HIPPA Network Compliance - Evaluation"
}

resource "sumologic_dashboard" "hippa_network_compliance_risk_analysis" {
  description = "This dashboards provides HIPPA network compliance risk analysis details like Top Suspicious Connections, Port spoofing activities"
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
        key       = "panelPANE-19896B569DC1F846"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":14}"
      }

      layout_structure {
        key       = "panelPANE-2F8DF99EB080DA44"
        structure = "{\"height\":8,\"width\":24,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-65F4453BBA06AA49"
        structure = "{\"height\":5,\"width\":12,\"x\":0,\"y\":14}"
      }

      layout_structure {
        key       = "panelPANE-894BC67FAF776947"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-19896B569DC1F846"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(ssl_validity_not_after) AND !isNull(ssl_common_name) AND app_name!=\"Unknown ssl\" AND app_name!=\"unknown\"\n| parseDate(ssl_validity_not_after, \"yyyy-MM-dd HH:mm:ss\") as endtime\n| now() as curtime\n| (endtime - curtime) as deltatime\n| ceil(deltatime / 86400000) as Days_To_Expiration  // Convert milliseconds to days\n| where Days_To_Expiration < 0\n| count ssl_common_name, app_name, Days_To_Expiration, ssl_validity_not_after\n| limit 100\n"
        query_type   = "Logs"
      }

      title           = "Total Expired Certificates in the Network"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Count\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-2F8DF99EB080DA44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where (app_name = \"ssh\" or app_name = \"dns\" or app_name = \"telnet\")\n  and src_port != 22 and dst_port != 22\n  and src_port != 53 and dst_port != 53\n  and src_port != 23 and dst_port != 23\n| count by src_ip, dst_ip, src_port, dst_port, app_name\n| sort by app_name desc\n"
        query_type   = "Logs"
      }

      title           = "Port Spoofing Activity"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-65F4453BBA06AA49"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(ssl_validity_not_after)\n| parseDate(ssl_validity_not_after, \"yyyy-MM-dd HH:mm:ss\") as endtime\n| now() as curtime\n| (endtime - curtime) as deltatime\n| ssl_certificate_subject_cn as Common_name\n| ceil(deltatime / 86400000) as Days_To_Expiration  // Convert milliseconds to days\n| where Days_To_Expiration < 0\n| count by Common_name,ssl_issuer,src_ip,Days_To_Expiration,ssl_validity_not_after\n| sort by _count\n| limit 100"
        query_type   = "Logs"
      }

      title           = "Self-Signed Certificates"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-894BC67FAF776947"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where app_name = \"ssh\"\n   or app_name = \"rdp\"\n   or app_name = \"telnet\"\n   or app_name = \"smb\"\n   or app_name = \"ftp\"\n   or app_name = \"dropbox\"\n   or app_name = \"nfs\"\n   or app_name = \"tftp\"\n| concat(src_ip, \"->\", dst_ip) as flow\n| dedup flow\n| where !(\n    (src_ip matches \"10.*\" and dst_ip matches \"10.*\") or\n    (src_ip matches \"192.168.*\" and dst_ip matches \"192.168.*\") or\n    (src_ip matches \"172.1[6-9].*\" and dst_ip matches \"172.1[6-9].*\") or\n    (src_ip matches \"172.2[0-9].*\" and dst_ip matches \"172.2[0-9].*\") or\n    (src_ip matches \"172.3[0-1].*\" and dst_ip matches \"172.3[0-1].*\")\n  )\n| count by app_name\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "Top Suspicious Connections"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "HIPPA Network Compliance - Risk Analysis"
}

resource "sumologic_dashboard" "hippa_network_compliance_technology_asset_inventory" {
  description = "This dashboards provides HIPPA network compliance for Technology Asset inventory details like HL7 version or Dicom application related details"
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
        key       = "panelPANE-0664D24F8BE94B49"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":32}"
      }

      layout_structure {
        key       = "panelPANE-18B750A5B90F1A40"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":14}"
      }

      layout_structure {
        key       = "panelPANE-2373400896547948"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":20}"
      }

      layout_structure {
        key       = "panelPANE-644BF0039BC2A948"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":38}"
      }

      layout_structure {
        key       = "panelPANE-648DBB09B45E6944"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":26}"
      }

      layout_structure {
        key       = "panelPANE-6E177B30ABDB5B47"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-9E12810195C76845"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":14}"
      }

      layout_structure {
        key       = "panelPANE-AB90A3E2B416FA4D"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":20}"
      }

      layout_structure {
        key       = "panelPANE-E49E0977B12D894F"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":32}"
      }

      layout_structure {
        key       = "panelPANE-F88832FDA5953844"
        structure = "{\"height\":8,\"width\":24,\"x\":0,\"y\":6}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-0664D24F8BE94B49"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(dicom_pdu_data_pdv_elem_val_cs)\n| count by dicom_pdu_data_pdv_elem_val_cs\n| limit 10"
        query_type   = "Logs"
      }

      title           = "DICOM Timeline"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-18B750A5B90F1A40"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json field=element \"app_name\" as app_name\n| where app_name matches \"*hl7*\"\n| timeslice 1d\n| count by app_name, _timeslice\n| transpose row _timeslice column app_name\n"
        query_type   = "Logs"
      }

      title           = "HL7 Versions Timeline"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-2373400896547948"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json field=element \"app_name\" as app_name\n| where app_name matches \"*hl7*\"\n| count by hl7_msg_seg_name"
        query_type   = "Logs"
      }

      title           = "HL7 Data Elements observed"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-644BF0039BC2A948"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(dicom_pdu_data_pdv_elem_val_cs)\n| src_ip as Source_IP\n| dst_ip as Destination_IP\n| count by Source_IP, Destination_IP,dicom_pdu_data_pdv_elem_val_cs, dicom_pdu_data_pdv_elem_val_pn\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "DICOM sessions involving trasnmission of medical images"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-648DBB09B45E6944"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where hl7_msg_seg_name == \"OBX\" or hl7_msg_seg_name == \"CTU\"\n| hl7_msg_seg_name as HL7_Msg\n| src_ip as Source_IP\n| dst_ip as Destination_IP\n| count by Source_IP, Destination_IP, HL7_Msg\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "HL7 sessions with Observations and Clinical Trial data"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-6E177B30ABDB5B47"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(dst_mac)\n| count by dst_mac\n| sort by _count\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Top Layer2 Devices"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"distribution\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-9E12810195C76845"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(hl7_version)\n| count by hl7_version\n| limit 10"
        query_type   = "Logs"
      }

      title           = "HL7 Versions"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-AB90A3E2B416FA4D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(hl7_msg_seg_name)\n| count by hl7_msg_seg_name\n| limit 10"
        query_type   = "Logs"
      }

      title           = "HL7 Data elements timeline"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-E49E0977B12D894F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(dicom_pdu_data_pdv_elem_val_cs)\n| count by dicom_pdu_data_pdv_elem_val_cs\n| limit 10"
        query_type   = "Logs"
      }

      title           = "DICOM medical images metadata"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-F88832FDA5953844"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name == \"hl7\" or app_name == \"dicom\"\n| app_name as Application\n| src_ip as Source_IP\n| dst_ip as Destination_IP\n| count by Application,Source_IP, Destination_IP\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Healthcare Protocol Sessions"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "HIPPA Network Compliance - Technology Asset Inventory"
}

resource "sumologic_dashboard" "identifier_analysis_url_analysis" {
  description = "Determining if a URL is benign or malicious by analyzing the URL or its components."
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
        key       = "panelPANE-10C09D50BCB41A4E"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":1}"
      }

      layout_structure {
        key       = "panelPANE-489839338CFFF941"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":13}"
      }

      layout_structure {
        key       = "panelPANE-6FC739388A42F84E"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":7}"
      }

      layout_structure {
        key       = "panelPANE-8410B91E81481A4C"
        structure = "{\"height\":1,\"width\":24,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-9C96D533B0C41847"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":1}"
      }

      layout_structure {
        key       = "panelPANE-9F2E564886AAFA46"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":7}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-10C09D50BCB41A4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(dns_name) and dns_name != \"\"\n| count by dns_name\n| sort by _count desc\n| limit 10\n\n"
        query_type   = "Logs"
      }

      title           = "Most Common URL's - Top 10"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-489839338CFFF941"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(dns_name) AND !isNull(dns_host)\n| dst_port as Port\n| dns_host as Domain\n| dns_name as URL\n| count by URL,Domain, port\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "URL Component Breakdown"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-6FC739388A42F84E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(dns_name) and dns_name != \"\"\n| timeslice 1d\n| count by dns_name, _timeslice\n| transpose row _timeslice column dns_name\n\n\n"
        query_type   = "Logs"
      }

      title           = "URL Activity"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[],\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-9C96D533B0C41847"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(dns_name) and dns_name != \"\"\n| count by dns_name\n| sort by _count desc\n| limit 50\n\n"
        query_type   = "Logs"
      }

      title           = "Number of Events Per URL"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-9F2E564886AAFA46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where dns_name != \"\" and dst_port != \"\" and isNull(dns_name)\n| count by dst_port\n| limit 100\n"
        query_type   = "Logs"
      }

      title           = "Port Usage Breakdown"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-8410B91E81481A4C"
      title                                       = "Determining if a URL is benign or malicious by analyzing the URL or its components."
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"text\":{\"format\":\"markdownV2\"},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "Identifier Analysis - URL Analysis"
}

resource "sumologic_dashboard" "m____dns_information" {
  description = "This dashboards provides DNS related information on M21-31 guidance to federal agencies on improving their investigative and remediation capabilities related to cybersecurity incidents"
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
        key       = "panelPANE-479351CAA139CB4B"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-49414BA9B01BE949"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-5624E28081341B4F"
        structure = "{\"height\":3,\"width\":24,\"x\":0,\"y\":35}"
      }

      layout_structure {
        key       = "panelPANE-569106A486EF4A4D"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-60A74E8ABA94AB48"
        structure = "{\"height\":5,\"width\":24,\"x\":0,\"y\":30}"
      }

      layout_structure {
        key       = "panelPANE-C02E1ABFA20ECA44"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-C4FB18739A66EA48"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":24}"
      }

      layout_structure {
        key       = "panelPANE-C7BFCEE2B998B845"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-C88E5E57AB3A3A4F"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":18}"
      }

      layout_structure {
        key       = "panelPANE-D60A7214850B9940"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":18}"
      }

      layout_structure {
        key       = "panelPANE-E742AB37BC077941"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-EFA6DE9DAE82E941"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":24}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-479351CAA139CB4B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where dns_query != \"\" and !isNull(dns_query)\n| timeslice by 1m\n| count by _timeslice, src_ip\n| sort by _timeslice\n"
        query_type   = "Logs"
      }

      title           = "Volume of DNS requests by Clients"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"area\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"fillOpacity\":0.25,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-49414BA9B01BE949"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where dns_query != \"\" and !isNull(dns_query)\n| timeslice by 1m\n| count by _timeslice, dst_ip\n| sort by _timeslice\n"
        query_type   = "Logs"
      }

      title           = "Top DNS Servers with Volume of Responses"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"area\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"fillOpacity\":0.25,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-5624E28081341B4F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where app_name = \"dns\"\n| concat(src_ip, \";\", dst_ip) as output\n| count_distinct(output)\n"
        query_type   = "Logs"
      }

      title           = "Unique Source/Destination Devices using DNS"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true,\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-569106A486EF4A4D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where dns_query != \"\" and !isNull(dns_query)\n| timeslice by 1m\n| count by _timeslice, dns_query\n| sort by _timeslice\n"
        query_type   = "Logs"
      }

      title           = "Top Domains Queried"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-60A74E8ABA94AB48"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| sum(src_bytes) as TxBytes, sum(dst_bytes) as RxBytes, sum(src_packets) as TxPackets, sum(dst_packets) as RxPackets by src_ip, dst_ip\n| sort by TxBytes desc, RxBytes desc\n"
        query_type   = "Logs"
      }

      title           = "Query Stats"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-C02E1ABFA20ECA44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where dns_query != \"\" and !isNull(dns_query)\n| timeslice by 1m\n| count by _timeslice\n| sort by _timeslice\n"
        query_type   = "Logs"
      }

      title           = "Volume of DNS Requests over time"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"area\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"fillOpacity\":0.25,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-C4FB18739A66EA48"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(dhcp_dns_server)\n| count by dhcp_dns_server\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "DNS Servers provided by DHCP"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-C7BFCEE2B998B845"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where dns_query != \"\" and !isNull(dns_query)\n| count by dns_query\n| sort by _count desc\n| limit 20\n"
        query_type   = "Logs"
      }

      title           = "Top 20 DNS Lookups"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-C88E5E57AB3A3A4F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(dns_query)\n| count by dns_query\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Top DNS Queries"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-D60A7214850B9940"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(dns_host)\n| count by dns_host\n| sort by _count\n| limit 20"
        query_type   = "Logs"
      }

      title           = "Top DNS Hostnames"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-E742AB37BC077941"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where app_name = \"dns\"\n| where !isNull(src_ip) and !isNull(dst_ip)\n| count by src_ip\n| sort by _count desc\n| limit 20\n"
        query_type   = "Logs"
      }

      title           = "Top DNS Clients"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-EFA6DE9DAE82E941"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(dns_query_type)\n| if(dns_query_type == 1, \"A\",\n    if(dns_query_type == 2, \"NS\",\n    if(dns_query_type == 3, \"MD\",\n    if(dns_query_type == 4, \"MF\",\n    if(dns_query_type == 5, \"CNAME\",\n    if(dns_query_type == 6, \"SOA\",\n    if(dns_query_type == 7, \"MB\",\n    if(dns_query_type == 8, \"MG\",\n    if(dns_query_type == 9, \"MR\",\n    if(dns_query_type == 10, \"NULL\",\n    if(dns_query_type == 11, \"WKS\",\n    if(dns_query_type == 12, \"PTR\",\n    if(dns_query_type == 13, \"HINFO\",\n    if(dns_query_type == 14, \"MINFO\",\n    if(dns_query_type == 15, \"MX\",\n    if(dns_query_type == 16, \"TXT\",\n    if(dns_query_type == 17, \"RP\",\n    if(dns_query_type == 18, \"AFSDB\",\n    if(dns_query_type == 19, \"X25\",\n    if(dns_query_type == 20, \"ISDN\",\n    if(dns_query_type == 21, \"RT\",\n    if(dns_query_type == 22, \"NSAP\",\n    if(dns_query_type == 23, \"NSAP-PTR\",\n    if(dns_query_type == 24, \"SIG\",\n    if(dns_query_type == 25, \"KEY\",\n    if(dns_query_type == 26, \"PX\",\n    if(dns_query_type == 27, \"GPOS\",\n    if(dns_query_type == 28, \"AAAA\",\n    if(dns_query_type == 29, \"LOC\",\n    if(dns_query_type == 30, \"NXT\",\n    if(dns_query_type == 31, \"EID\",\n    if(dns_query_type == 32, \"NIMLOC\",\n    if(dns_query_type == 33, \"SRV\",\n    if(dns_query_type == 34, \"ATMA\",\n    if(dns_query_type == 35, \"NAPTR\",\n    if(dns_query_type == 36, \"KX\",\n    if(dns_query_type == 37, \"CERT\",\n    if(dns_query_type == 38, \"A6\",\n    if(dns_query_type == 39, \"DNAME\",\n    if(dns_query_type == 40, \"SINK\",\n    if(dns_query_type == 41, \"OPT\",\n    if(dns_query_type == 42, \"APL\",\n    if(dns_query_type == 43, \"DS\",\n    if(dns_query_type == 44, \"SSHFP\",\n    if(dns_query_type == 45, \"IPSECKEY\",\n    if(dns_query_type == 46, \"RRSIG\",\n    if(dns_query_type == 47, \"NSEC\",\n    if(dns_query_type == 48, \"DNSKEY\",\n    if(dns_query_type == 49, \"DHCID\",\n    if(dns_query_type == 50, \"NSEC3\",\n    if(dns_query_type == 51, \"NSEC3PARAM\",\n    if(dns_query_type == 52, \"TLSA\",\n    if(dns_query_type == 53, \"SMIMEA\",\n    if(dns_query_type == 54, \"Unassigned\",\n    if(dns_query_type == 55, \"HIP\",\n    if(dns_query_type == 56, \"NINFO\",\n    if(dns_query_type == 57, \"RKEY\",\n    if(dns_query_type == 58, \"TALINK\",\n    if(dns_query_type == 59, \"CDS\",\n    if(dns_query_type == 60, \"CDNSKEY\",\n    if(dns_query_type == 61, \"OPENPGPKEY\",\n    if(dns_query_type == 62, \"CSYNC\",\n    if(dns_query_type == 63, \"ZONEMD\",\n    if(dns_query_type == 99, \"SPF\",\n    if(dns_query_type == 100, \"UINFO\",\n    if(dns_query_type == 101, \"UID\",\n    if(dns_query_type == 102, \"GID\",\n    if(dns_query_type == 103, \"UNSPEC\",\n    if(dns_query_type == 104, \"NID\",\n    if(dns_query_type == 105, \"L32\",\n    if(dns_query_type == 106, \"L64\",\n    if(dns_query_type == 107, \"LP\",\n    if(dns_query_type == 108, \"EU148\",\n    if(dns_query_type == 109, \"EU164\",\n    if(dns_query_type == 249, \"TKEY\",\n    if(dns_query_type == 250, \"TSIG\",\n    if(dns_query_type == 251, \"IXFR\",\n    if(dns_query_type == 252, \"AXFR\",\n    if(dns_query_type == 253, \"MAILB\",\n    if(dns_query_type == 254, \"MAILA\",\n    if(dns_query_type == 255, \"*\",\n    if(dns_query_type == 256, \"URI\",\n    if(dns_query_type == 257, \"CAA\",\n    if(dns_query_type == 258, \"AVC\",\n    if(dns_query_type == 259, \"DOA\",\n    if(dns_query_type == 260, \"AMTRELAY\",\n    if(dns_query_type == 32768, \"TA\",\n    if(dns_query_type == 32769, \"DLV\",\n    if(dns_query_type == 505, \"HTTP\",\n    if(dns_query_type == 424, \"TYPEUNSPEC\",\n    dns_query_type\n  )))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) as DNS_Query_Type\n| count by dns_query_type\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "DNS Query Type"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "M21-31 - DNS Information"
}

resource "sumologic_dashboard" "m____web_traffic_details" {
  description = "This dashboards provides Web Traffic related information on M21-31 guidance to federal agencies on improving their investigative and remediation capabilities related to cybersecurity incidents"
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
        key       = "panelPANE-02FD4936A3AF0A4E"
        structure = "{\"height\":8,\"width\":5,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-231CFAE4B79BC942"
        structure = "{\"height\":6,\"width\":9,\"x\":7,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-3B6F6A0F97EBAA48"
        structure = "{\"height\":8,\"width\":5,\"x\":5,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-4164794A8FA67A41"
        structure = "{\"height\":7,\"width\":24,\"x\":0,\"y\":14}"
      }

      layout_structure {
        key       = "panelPANE-6BCF67CE84AEB948"
        structure = "{\"height\":8,\"width\":5,\"x\":15,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-A37EF6AF97AFA84E"
        structure = "{\"height\":8,\"width\":4,\"x\":20,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-B41902698837684C"
        structure = "{\"height\":8,\"width\":5,\"x\":10,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-B67892679ADD5B42"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":21}"
      }

      layout_structure {
        key       = "panelPANE-BC54941F984E194E"
        structure = "{\"height\":6,\"width\":7,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-E5DECF459BF3EA45"
        structure = "{\"height\":6,\"width\":8,\"x\":16,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-02FD4936A3AF0A4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(http_method)\n| count by http_method\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Http Method"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-231CFAE4B79BC942"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where http_user_agent != \"\" and !isNull(http_user_agent)\n| count by http_user_agent\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "Client Browsers"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-3B6F6A0F97EBAA48"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(http_code)\n| count by http_code\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Http Code"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"distribution\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-4164794A8FA67A41"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where (http_method = \"POST\" or http_method = \"PUT\") and http_content_type != \"\" and !isNull(http_content_type)\n| count by http_method, http_content_type, src_ip, dst_ip, http_server\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "Session info for unsafe Http methods"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-6BCF67CE84AEB948"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where http_file_type != \"\" and !isNull(http_file_type)\n| count by http_file_type\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "File Types"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-A37EF6AF97AFA84E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where http_referer != \"\" and !isNull(http_referer)\n| count by http_referer\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "Top Referer sites"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-B41902698837684C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(http_version)\n| count by http_version\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Version"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-B67892679ADD5B42"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where app_name = \"http\" and dst_port != 80 and src_port != 80\n| count by src_ip, dst_ip, src_port, dst_port\n"
        query_type   = "Logs"
      }

      title           = "Http communication on non-standard ports"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-BC54941F984E194E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"http\" or app_name matches \"https\" or app_name matches \"http2\"\n| count by app_name\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "Encrypted vs Non Encrypted Traffic"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-E5DECF459BF3EA45"


      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(http_server_agent)\n| count by http_server_agent\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Server Software"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "M21-31 - Web Traffic details"
}

resource "sumologic_dashboard" "pci_compliance_cardholder_data_protection" {
  description = "This dashboard provides Tracking and monitoring of all access to network resources and cardholder data"
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
        key       = "panelPANE-0B275A4B93A1A94C"
        structure = "{\"height\":2,\"width\":24,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-33F6D54282B59A4A"
        structure = "{\"height\":9,\"width\":24,\"x\":0,\"y\":16}"
      }

      layout_structure {
        key       = "panelPANE-3B6F6A0F97EBAA48"
        structure = "{\"height\":8,\"width\":24,\"x\":0,\"y\":25}"
      }

      layout_structure {
        key       = "panelPANE-A747609FBF4DFA42"
        structure = "{\"height\":7,\"width\":12,\"x\":12,\"y\":33}"
      }

      layout_structure {
        key       = "panelPANE-D1AF4F938E75BB4E"
        structure = "{\"height\":7,\"width\":12,\"x\":0,\"y\":33}"
      }

      layout_structure {
        key       = "panelPANE-EEBD983EBAA94944"
        structure = "{\"height\":14,\"width\":24,\"x\":0,\"y\":2}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-33F6D54282B59A4A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(src_ip) and !isNull(dst_ip)\n| concat(src_ip, \"->\", dst_ip) as conversation\n| count by conversation\n| sort by _count desc\n| limit 10\n"
        query_type   = "Logs"
      }

      title           = "Top IP conversations"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-3B6F6A0F97EBAA48"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(dst_mac)\n| count by dst_mac\n| sort by _count\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Top Layer2 Devices"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"distribution\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-A747609FBF4DFA42"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where dst_port > 0\n| count by dst_port\n| sort by _count desc\n| limit 11\n"
        query_type   = "Logs"
      }

      title           = "Top 10 Destination Ports"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-D1AF4F938E75BB4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where src_port > 0\n| count by src_port\n| sort by _count desc\n| limit 11\n"
        query_type   = "Logs"
      }

      title           = "Top 10 Source Ports"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-EEBD983EBAA94944"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(src_ip) and !isNull(dst_ip) and !isNull(src_bytes) and !isNull(dst_bytes)\n| concat(src_ip, \"->\", dst_ip) as conversation\n| sum(src_bytes) as TxBytes, sum(dst_bytes) as RxBytes by conversation\n| sort by TxBytes desc\n| limit 10\n"
        query_type   = "Logs"
      }

      title           = "Top Traffic Conversations"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"distribution\"},\"overrides\":[]}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-0B275A4B93A1A94C"
      text                                        = "Look for PCI compliant devices talking to non-compliant devices\n"
      title                                       = "Track and monitor all access to network resources and cardholder data"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"text\":{\"format\":\"markdownV2\",\"fontSize\":15,\"horizontalAlignment\":\"left\",\"textColor\":\"#066180\"},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "PCI Compliance - Cardholder Data Protection"
}

resource "sumologic_dashboard" "pci_compliance_secure_data_transmission" {
  description = "This dashboard helps user to secure their data transmission by ensuring their web traffic, weak ciphers and protocol details."
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
        key       = "panelPANE-1C7D8135AC17C847"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":21}"
      }

      layout_structure {
        key       = "panelPANE-320B2DD5B281CB46"
        structure = "{\"height\":7,\"width\":24,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-66AED58E9F9B3A44"
        structure = "{\"height\":6,\"width\":6,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-678EB7DB83C8CB4C"
        structure = "{\"height\":6,\"width\":6,\"x\":18,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-6F028C6BB13DDA4C"
        structure = "{\"height\":8,\"width\":8,\"x\":0,\"y\":13}"
      }

      layout_structure {
        key       = "panelPANE-AFFCA5BD9EABBB49"
        structure = "{\"height\":6,\"width\":7,\"x\":5,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-B7977DE8B3326A45"
        structure = "{\"height\":8,\"width\":7,\"x\":17,\"y\":13}"
      }

      layout_structure {
        key       = "panelPANE-BC54941F984E194E"
        structure = "{\"height\":6,\"width\":5,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-D8BF9774925F184F"
        structure = "{\"height\":8,\"width\":9,\"x\":8,\"y\":13}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-1C7D8135AC17C847"

      query {
        query_key    = "A"
        query_string = "\n_sourceCategory=Gigamon\n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(ssl_protocol_version)\n| where ssl_protocol_version == \"TLS_1_3\" OR ssl_protocol_version == \"TLS_1_2\" or ssl_protocol_version == \"TLS_1_1\"\n| count by ssl_protocol_version, src_ip, dst_ip, app_name\n| sort by _count desc"
        query_type   = "Logs"
      }

      title           = "Sessions using Old SSL Versions - Applications, Servers and Clients using deprecated and risky SSL versions"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-320B2DD5B281CB46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(ssl_validity_not_after) AND !isNull(ssl_common_name) AND app_name!=\"Unknown ssl\" AND app_name!=\"unknown\"\n| parseDate(ssl_validity_not_after, \"yyyy-MM-dd HH:mm:ss\") as endtime\n| now() as curtime\n| (endtime - curtime) as deltatime\n| ceil(deltatime / 86400000) as Days_To_Expiration  // Convert milliseconds to days\n| where Days_To_Expiration < 0\n| count by ssl_issuer,app_name,src_ip,Days_To_Expiration,ssl_validity_not_after\n| sort by _count\n| limit 100"
        query_type   = "Logs"
      }

      title           = "Expired TLS Certificates"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-66AED58E9F9B3A44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(ssl_ext_sig_algorithm_sig)\n| if(ssl_ext_sig_algorithm_sig == \"0\", \"anonymous\",\n  if(ssl_ext_sig_algorithm_sig == \"1\", \"RSA\",\n  if(ssl_ext_sig_algorithm_sig == \"2\", \"DSA\",\n  if(ssl_ext_sig_algorithm_sig == \"3\", \"ECDSA\",\n     ssl_ext_sig_algorithm_sig)))) as Signature\n| count by Signature\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "Key Exchange Protocols"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-678EB7DB83C8CB4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(ssl_protocol_version)\n| if(ssl_protocol_version == \"768\", \"SSLv3\",\n  if(ssl_protocol_version == \"769\", \"TLS1.0\",\n  if(ssl_protocol_version == \"770\", \"TLS1.1\",\n  if(ssl_protocol_version == \"771\", \"TLS1.2\",\n  if(ssl_protocol_version == \"2\",   \"SSLv2\",\n     ssl_protocol_version))))) as version_label\n| count by version_label\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "TLS Versions"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-6F028C6BB13DDA4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(ssl_validity_not_after) AND !isNull(ssl_common_name) AND app_name!=\"Unknown ssl\" AND app_name!=\"unknown\"\n| parseDate(ssl_validity_not_after, \"yyyy-MM-dd HH:mm:ss\") as endtime\n| now() as curtime\n| (endtime - curtime) as deltatime\n| ceil(deltatime / 86400000) as Days_To_Expiration  // Convert milliseconds to days\n| where Days_To_Expiration < 0\n| count ssl_common_name, app_name, Days_To_Expiration, ssl_validity_not_after\n| limit 100\n"
        query_type   = "Logs"
      }

      title           = "Total Expired Certificates"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-AFFCA5BD9EABBB49"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(ssl_cipher_suite_id)\n| count by ssl_cipher_suite_id\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Weak Ciphers"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-B7977DE8B3326A45"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(ssl_ext_sig_algorithm_hash)\n| if(ssl_ext_sig_algorithm_hash == \"0\", \"None\",\n  if(ssl_ext_sig_algorithm_hash == \"1\", \"MD5\",\n  if(ssl_ext_sig_algorithm_hash == \"2\", \"SHA1\",\n  if(ssl_ext_sig_algorithm_hash == \"3\", \"SHA224\",\n  if(ssl_ext_sig_algorithm_hash == \"4\", \"SHA256\",\n     ssl_ext_sig_algorithm_hash))))) as Hash\n| count by Hash\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "Cryptographic Hash"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-BC54941F984E194E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"http\" or app_name matches \"https\" or app_name matches \"http2\"\n| count by app_name\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "Web Traffic"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-D8BF9774925F184F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(ssl_validity_not_after) AND !isNull(ssl_common_name) AND app_name!=\"Unknown ssl\" AND app_name!=\"unknown\"\n| parseDate(ssl_validity_not_after, \"yyyy-MM-dd HH:mm:ss\") as endtime\n| now() as curtime\n| (endtime - curtime) as deltatime\n| ceil(deltatime / 86400000) as Days_To_Expiration  // Convert milliseconds to days\n| where Days_To_Expiration < 8\n| count ssl_common_name, app_name, Days_To_Expiration, ssl_validity_not_after\n| limit 100\n"
        query_type   = "Logs"
      }

      title           = "Expired Certificates in a Week"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "PCI Compliance - Secure Data Transmission"
}

resource "sumologic_dashboard" "pci_compliance_secure_systems_and_insecure_protocol_insights" {
  description = "This dashboard develops and maintain secure systems and applications"
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
        key       = "panelPANE-0A89DFF086979941"
        structure = "{\"height\":6,\"width\":6,\"x\":6,\"y\":19}"
      }

      layout_structure {
        key       = "panelPANE-0B275A4B93A1A94C"
        structure = "{\"height\":4,\"width\":24,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-297536DB8C03BB46"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":4}"
      }

      layout_structure {
        key       = "panelPANE-39EFB283855FCA47"
        structure = "{\"height\":6,\"width\":6,\"x\":0,\"y\":19}"
      }

      layout_structure {
        key       = "panelPANE-5F3BD8C69381EA46"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":10}"
      }

      layout_structure {
        key       = "panelPANE-7E76CED0BC7FEB4E"
        structure = "{\"height\":6,\"width\":6,\"x\":12,\"y\":19}"
      }

      layout_structure {
        key       = "panelPANE-928E21A689F26B43"
        structure = "{\"height\":6,\"width\":6,\"x\":18,\"y\":19}"
      }

      layout_structure {
        key       = "panelPANE-9C94E7868A2CB84C"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":4}"
      }

      layout_structure {
        key       = "panelPANE-E51DD5F0A9B50947"
        structure = "{\"height\":3,\"width\":24,\"x\":0,\"y\":16}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-0A89DFF086979941"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where app_name = \"snmp\" and (snmp_version = \"1\" or snmp_version = \"2c\")\n| count by snmp_version\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "SNMP Version"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-297536DB8C03BB46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where app_name = \"ssh\" and dst_port != 22 and src_port != 22\n| count\n"
        query_type   = "Logs"
      }

      title           = "SSH sessions - Non Standard Port"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-39EFB283855FCA47"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where app_name = \"telnet\" or app_name = \"ftp\" or app_name = \"imap\" or app_name = \"pop3\"\n| count by app_name\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "Insecure protocols"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-5F3BD8C69381EA46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where app_name = \"ssh\" and dst_port != 22 and src_port != 22\n| count by src_ip, dst_port, src_port\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "SSH sessions on non-standard port"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-7E76CED0BC7FEB4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where app_name == \"smb\"\n| count by smb_version\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "SMB versions"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-928E21A689F26B43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where http_version = \"1.0\" or http_version = \"1.1\" or http_version = \"1.2\"\n| count by http_version\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "HTTP Versions"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-9C94E7868A2CB84C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where app_name != \"0\"\n  and app_name != \"unknown\"\n  and app_name != \"Classification-unknown\"\n  and app_name != \"Unknown tcp\"\n  and app_name != \"Unknown udp\"\n| count by app_name\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "Applications Overview for unauthorized Apps"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-0B275A4B93A1A94C"
      text                                        = "Look for :\n\n - unauthorized applications\n\n- port sppofing\n\n- unauthorized Access\n\n"
      title                                       = "Develop and maintain secure systems and applications"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"text\":{\"format\":\"markdownV2\",\"fontSize\":15,\"horizontalAlignment\":\"left\",\"textColor\":\"#066180\"},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-E51DD5F0A9B50947"
      text                                        = "Services, protocols, or ports that transmit data or authentication credentials (for example, password/passphrase) in clear-text over the Internet.\n\nExamples of insecure services, protocols, or ports include but are not limited to FTP,Telnet,POP3,IMAP,SNMP v1 and v2,SMB v1 and v2."
      title                                       = "Insecure Protocol/Service/Port"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"text\":{\"format\":\"markdownV2\",\"fontSize\":15,\"horizontalAlignment\":\"center\",\"textColor\":\"#066180\"},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "PCI Compliance - Secure Systems and Insecure Protocol Insights"
}

resource "sumologic_dashboard" "rogue_activity_cryptojacketing" {
  description = "This dashboard provides any unauthorized or unapproved device, application, or activity that connects to or operates within a network without proper authorization on CryptoJaketing"
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
        key       = "panelPANE-12BD15B6888C6A4E"
        structure = "{\"height\":16,\"width\":24,\"x\":0,\"y\":20}"
      }

      layout_structure {
        key       = "panelPANE-22274F78BE938A44"
        structure = "{\"height\":8,\"width\":8,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-348EC7F4A0FF1B46"
        structure = "{\"height\":8,\"width\":8,\"x\":8,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-4EB77BCBA6901B4E"
        structure = "{\"height\":8,\"width\":8,\"x\":16,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-77201AF3B27ED84F"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-88F0A328B1D1BB4D"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-99D70783B8C4DA45"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-E6EB2B2EB58E6B4A"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-12BD15B6888C6A4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"*bitcoin*\" OR app_name matches \"*monero*\" OR app_name matches \"*ripple*\" OR app_name matches \"*ethereum*\" OR app_name matches \"*minexmr_com*\" OR app_name matches \"*xmrpool_eu*\" OR app_name matches \"*crypto_pool_fr*\" OR app_name matches \"*monerohash_com*\" OR app_name matches \"*minergate_com*\" OR app_name matches \"*coinimp*\" OR app_name matches \"*ethereum_nd*\" OR app_name matches \"*minexmr-com*\" OR app_name matches \"*monerohash-com*\" OR app_name matches \"*minergate-com*\" OR app_name matches \"*xmrpool-eu*\" OR app_name matches \"*ethereum-nd*\"\n| geoip src_ip\n| count by latitude, longitude\n| sort _count"
        query_type   = "Logs"
      }

      title           = "Geolocation Info of Cryptomining activity by Source IP"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-22274F78BE938A44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(src_ip) AND app_name matches \"*bitcoin*\" OR app_name matches \"*monero*\" OR app_name matches \"*ripple*\" OR app_name matches \"*ethereum*\" OR app_name matches \"*minexmr_com*\" OR app_name matches \"*xmrpool_eu*\" OR app_name matches \"*crypto_pool_fr*\" OR app_name matches \"*monerohash_com*\" OR app_name matches \"*minergate_com*\" OR app_name matches \"*coinimp*\" OR app_name matches \"*ethereum_nd*\" OR app_name matches \"*minexmr-com*\" OR app_name matches \"*monerohash-com*\" OR app_name matches \"*minergate-com*\" OR app_name matches \"*xmrpool-eu*\" OR app_name matches \"*ethereum-nd*\"\n| count by src_ip\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Top Cryptomining Sources"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-348EC7F4A0FF1B46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(dst_ip) AND app_name matches \"*bitcoin*\" OR app_name matches \"*monero*\" OR app_name matches \"*ripple*\" OR app_name matches \"*ethereum*\" OR app_name matches \"*minexmr_com*\" OR app_name matches \"*xmrpool_eu*\" OR app_name matches \"*crypto_pool_fr*\" OR app_name matches \"*monerohash_com*\" OR app_name matches \"*minergate_com*\" OR app_name matches \"*coinimp*\" OR app_name matches \"*ethereum_nd*\" OR app_name matches \"*minexmr-com*\" OR app_name matches \"*monerohash-com*\" OR app_name matches \"*minergate-com*\" OR app_name matches \"*xmrpool-eu*\" OR app_name matches \"*ethereum-nd*\"\n| count by dst_ip\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Top Cryptomining destinations"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-4EB77BCBA6901B4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where app_name != \"0\"\n  and (app_name = \"bitcoin\"\n    or app_name = \"monero\"\n    or app_name = \"minexmr_com\"\n    or app_name = \"ripple\"\n    or app_name = \"ethereum\"\n    or app_name = \"xmrpool_eu\"\n    or app_name = \"crypto_pool_fr\"\n    or app_name = \"monerohash_com\"\n    or app_name = \"minergate_com\"\n    or app_name = \"coinimp\"\n    or app_name = \"ethereum_nd\"\n    or app_name = \"minexmr-com\"\n    or app_name = \"monerohash-com\"\n    or app_name = \"minergate-com\"\n    or app_name = \"xmrpool-eu\"\n    or app_name = \"ethereum-nd\")\n| count by app_name\n| sort by _count desc\n"
        query_type   = "Logs"
      }

      title           = "Applications"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-77201AF3B27ED84F"


      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"*ethereum*\" OR app_name matches \"*monero*\" OR app_name matches \"*bitcoin*\" OR app_name matches \"*minergate*\" OR app_name matches \"*xmr*\"\n| count by app_name"
        query_type   = "Logs"
      }

      title           = "List of Cryptomining Applications in your network"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-88F0A328B1D1BB4D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"*bitcoin*\" OR app_name matches \"*monero*\" OR app_name matches \"*ripple*\" OR app_name matches \"*ethereum*\" OR app_name matches \"*minexmr_com*\" OR app_name matches \"*xmrpool_eu*\" OR app_name matches \"*crypto_pool_fr*\" OR app_name matches \"*monerohash_com*\" OR app_name matches \"*minergate_com*\" OR app_name matches \"*coinimp*\" OR app_name matches \"*ethereum_nd*\" OR app_name matches \"*minexmr-com*\" OR app_name matches \"*monerohash-com*\" OR app_name matches \"*minergate-com*\" OR app_name matches \"*xmrpool-eu*\" OR app_name matches \"*ethereum-nd*\" OR app_name matches \"*ethereum*\"\n| count by app_name,src_ip \n| sort by _count desc"
        query_type   = "Logs"
      }

      title           = "Top Endpoints Involved in Cryptomining Activity"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-99D70783B8C4DA45"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"*bitcoin*\" OR app_name matches \"*monero*\" OR app_name matches \"*ripple*\" OR app_name matches \"*ethereum*\" OR app_name matches \"*minexmr_com*\" OR app_name matches \"*xmrpool_eu*\" OR app_name matches \"*crypto_pool_fr*\" OR app_name matches \"*monerohash_com*\" OR app_name matches \"*minergate_com*\" OR app_name matches \"*coinimp*\" OR app_name matches \"*ethereum_nd*\" OR app_name matches \"*minexmr-com*\" OR app_name matches \"*monerohash-com*\" OR app_name matches \"*minergate-com*\" OR app_name matches \"*xmrpool-eu*\" OR app_name matches \"*ethereum-nd*\"\n| count app_name, src_ip, dst_ip\n"
        query_type   = "Logs"
      }

      title           = "Number of cryptomining sessions"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true,\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Count\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"Sessions\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-E6EB2B2EB58E6B4A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"*bitcoin*\" OR app_name matches \"*monero*\" OR app_name matches \"*ripple*\" OR app_name matches \"*ethereum*\"  OR app_name matches \"*minexmr_com*\"  OR app_name matches \"*xmrpool_eu*\"  OR app_name matches \"*crypto_pool_fr*\"  OR app_name matches \"*monerohash_com*\"  OR app_name matches \"*minergate_com*\" OR app_name matches \"*coinimp*\" OR app_name matches \"*ethereum_nd*\" OR app_name matches \"*minexmr-com*\"  OR app_name matches \"*monerohash-com*\" OR app_name matches \"*minergate-com*\" OR app_name matches \"*xmrpool-eu*\"  OR app_name matches \"*ethereum-nd*\"\n| (src_bytes + dst_bytes) as total_bytes\n| count by app_name,total_bytes"
        query_type   = "Logs"
      }

      title           = "Cryptomining Traffic Over time"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "Rogue Activity - Cryptojacketing"
}

resource "sumologic_dashboard" "rogue_activity_unsanctioned_peer_to_peer_apps" {
  description = "This dahsboard provides any unauthorized or unapproved device, application, or activity that connects to or operates within a network without proper authorization with Unsanctioned peer to peer apps details"
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
        key       = "panelPANE-0854FCDDA4C8FA4F"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-24878E0582103942"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-461F5985B5093A48"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":26}"
      }

      layout_structure {
        key       = "panelPANE-471A14998CB85844"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-4A6A49E19832E849"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-63ED374EB9BE094E"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-7ED69E8892B1184E"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":26}"
      }

      layout_structure {
        key       = "panelPANE-B344DF2A9BFA7840"
        structure = "{\"height\":8,\"width\":24,\"x\":0,\"y\":18}"
      }

      layout_structure {
        key       = "panelPANE-C54002A6B5D1784B"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":12}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-0854FCDDA4C8FA4F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"*bittorrent*\" OR app_name matches \"*apple-airplay*\" OR app_name matches \"*ripple*\" OR app_name matches \"*ethereum*\"  OR app_name matches \"*bittorrent-bundle*\"  OR app_name matches \"*gnutella*\"  OR app_name matches \"*manolito*\"  OR app_name matches \"*utorrent*\"  OR app_name matches \"*bitcomet*\" OR app_name matches \"*bitcomet-pex*\" OR app_name matches \"*ares*\" OR app_name matches \"*imesh*\"  OR app_name matches \"*directconnect*\" OR app_name matches \"*slsk*\" \n| count app_name, src_ip, dst_ip\n"
        query_type   = "Logs"
      }

      title           = "Number of P2P sessions"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Count\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"Sessions\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-24878E0582103942"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"*gnut*\" OR app_name matches \"*donkey*\" OR app_name matches \"*torrent*\" OR app_name matches \"*slsk*\" OR app_name matches \"*manolito*\"\n| count by app_name"
        query_type   = "Logs"
      }

      title           = "P2P Apps detected"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-461F5985B5093A48"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"*bittorrent*\" OR app_name matches \"*apple-airplay*\" OR app_name matches \"*ripple*\" OR app_name matches \"*ethereum*\"  OR app_name matches \"*bittorrent-bundle*\"  OR app_name matches \"*gnutella*\"  OR app_name matches \"*manolito*\"  OR app_name matches \"*utorrent*\"  OR app_name matches \"*bitcomet*\" OR app_name matches \"*bitcomet-pex*\" OR app_name matches \"*ares*\" OR app_name matches \"*imesh*\"  OR app_name matches \"*directconnect*\" OR app_name matches \"*slsk *\" \n| count by dst_ip\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Top P2P Destinations"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-471A14998CB85844"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"*bittorrent*\" OR app_name matches \"*apple-airplay*\" OR app_name matches \"*ripple*\" OR app_name matches \"*ethereum*\"  OR app_name matches \"*bittorrent-bundle*\"  OR app_name matches \"*gnutella*\"  OR app_name matches \"*manolito*\"  OR app_name matches \"*utorrent*\"  OR app_name matches \"*bitcomet*\" OR app_name matches \"*bitcomet-pex*\" OR app_name matches \"*ares*\" OR app_name matches \"*imesh*\"  OR app_name matches \"*directconnect*\" OR app_name matches \"*slsk *\" | (src_bytes + dst_bytes) as total_bytes\n| count by app_name,total_bytes"
        query_type   = "Logs"
      }

      title           = "P2P Application traffic over time"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-4A6A49E19832E849"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"*gnutella*\" OR app_name matches \"*torrent*\" OR app_name matches \"*edonkey*\" OR app_name matches \"*manolito*\" \n| count by app_name,src_ip,dst_ip"
        query_type   = "Logs"
      }

      title           = "P2P App sessions"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-63ED374EB9BE094E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches  \"*torrent*\"\n| count by bittorrent_client_version"
        query_type   = "Logs"
      }

      title           = "P2P Client Software Versions"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Light\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-7ED69E8892B1184E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"*bittorrent*\" OR app_name matches \"*apple-airplay*\" OR app_name matches \"*ripple*\" OR app_name matches \"*ethereum*\"  OR app_name matches \"*bittorrent-bundle*\"  OR app_name matches \"*gnutella*\"  OR app_name matches \"*manolito*\"  OR app_name matches \"*utorrent*\"  OR app_name matches \"*bitcomet*\" OR app_name matches \"*bitcomet-pex*\" OR app_name matches \"*ares*\" OR app_name matches \"*imesh*\"  OR app_name matches \"*directconnect*\" OR app_name matches \"*slsk *\" \n| count by src_ip\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Top P2P Sources"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-B344DF2A9BFA7840"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"*bittorrent*\" OR app_name matches \"*apple-airplay*\" OR app_name matches \"*ripple*\" OR app_name matches \"*ethereum*\"  OR app_name matches \"*bittorrent-bundle*\"  OR app_name matches \"*gnutella*\"  OR app_name matches \"*manolito*\"  OR app_name matches \"*utorrent*\"  OR app_name matches \"*bitcomet*\" OR app_name matches \"*bitcomet-pex*\" OR app_name matches \"*ares*\" OR app_name matches \"*imesh*\"  OR app_name matches \"*directconnect*\" OR app_name matches \"*slsk *\" \n| geoip src_ip\n| count by latitude, longitude\n| sort _count"
        query_type   = "Logs"
      }

      title           = "Geolocation of P2P activity by Source Address"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-C54002A6B5D1784B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches  \"*torrent*\"\n| count by bittorrent_user_agent"
        query_type   = "Logs"
      }

      title           = "P2P Client Software seen"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"distribution\"},\"overrides\":[]}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "Rogue Activity - Unsanctioned Peer to Peer Apps"
}

resource "sumologic_dashboard" "security_posture_ssl_certificate_info" {
  description = "This dashboard provides security posture details on SSL Certificate information to identify and work on the expired self-signed certs "
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
        key       = "panelPANE-36B91783982E8B46"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-41714DD88885C949"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-51F66E4AB8CCD94B"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-CE73A5D396F7C84E"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":6}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-36B91783982E8B46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(ssl_validity_not_after)\n| parseDate(ssl_validity_not_after, \"yyyy-MM-dd HH:mm:ss\") as endtime\n| now() as curtime\n| (endtime - curtime) as deltatime\n| ssl_certificate_subject_cn as Common_name\n| ceil(deltatime / 86400000) as Days_To_Expiration  // Convert milliseconds to days\n| where Days_To_Expiration < 0 and !isNull(ssl_certificate_subject_cn)\n| count by Common_name,ssl_issuer,src_ip,Days_To_Expiration,ssl_validity_not_after\n| sort by _count\n| limit 100"
        query_type   = "Logs"
      }

      title           = "Self Signed Certificates"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-41714DD88885C949"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(ssl_validity_not_after) AND !isNull(ssl_common_name) AND app_name!=\"Unknown ssl\" AND app_name!=\"unknown\"\n| parseDate(ssl_validity_not_after, \"yyyy-MM-dd HH:mm:ss\") as endtime\n| now() as curtime\n| (endtime - curtime) as deltatime\n| ceil(deltatime / 86400000) as Days_To_Expiration  // Convert milliseconds to days\n| where Days_To_Expiration < 8\n| count ssl_common_name, app_name, Days_To_Expiration, ssl_validity_not_after\n| limit 100\n"
        query_type   = "Logs"
      }

      title           = "Certificates About To Expire In A Week"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Count\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-51F66E4AB8CCD94B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(ssl_validity_not_after) AND !isNull(ssl_common_name) AND app_name!=\"Unknown ssl\" AND app_name!=\"unknown\"\n| parseDate(ssl_validity_not_after, \"yyyy-MM-dd HH:mm:ss\") as endtime\n| now() as curtime\n| (endtime - curtime) as deltatime\n| ceil(deltatime / 86400000) as Days_To_Expiration  // Convert milliseconds to days\n| where Days_To_Expiration < 0\n| count ssl_common_name, app_name, Days_To_Expiration, ssl_validity_not_after\n| limit 100\n"
        query_type   = "Logs"
      }

      title           = "Total Expired Certificates In The Network"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Count\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-CE73A5D396F7C84E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(ssl_validity_not_after) AND !isNull(ssl_common_name) AND app_name!=\"Unknown ssl\" AND app_name!=\"unknown\"\n| parseDate(ssl_validity_not_after, \"yyyy-MM-dd HH:mm:ss\") as endtime\n| now() as curtime\n| (endtime - curtime) as deltatime\n| ceil(deltatime / 86400000) as Days_To_Expiration  // Convert milliseconds to days\n| where Days_To_Expiration < 0\n| count by ssl_issuer,app_name,src_ip,Days_To_Expiration,ssl_validity_not_after\n| sort by _count\n| limit 100"
        query_type   = "Logs"
      }

      title           = "Certificate Details"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "Security Posture - SSL Certificate Info"
}

resource "sumologic_dashboard" "security_posture_ssl_cryptographic_details" {
  description = "This dashboard provides Cryptographic SSL details to secure data by identifying Weak ciphers, Signature algorithms and TLS information"
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
        key       = "panel76223013B1B1CA45"
        structure = "{\"height\":9,\"width\":14,\"x\":10,\"y\":16}"
      }

      layout_structure {
        key       = "panelPANE-1801CE7CB24E894F"
        structure = "{\"height\":8,\"width\":5,\"x\":9,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-31C5629CBCC98946"
        structure = "{\"height\":8,\"width\":5,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-3BC25FFDB8353B45"
        structure = "{\"height\":8,\"width\":5,\"x\":19,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-85268093ACE72840"
        structure = "{\"height\":8,\"width\":5,\"x\":14,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-8BFC60BD968B784D"
        structure = "{\"height\":8,\"width\":14,\"x\":10,\"y\":8}"
      }

      layout_structure {
        key       = "panelPANE-94EB4163BDBBF844"
        structure = "{\"height\":9,\"width\":10,\"x\":0,\"y\":16}"
      }

      layout_structure {
        key       = "panelPANE-C2EF90B1A007B841"
        structure = "{\"height\":8,\"width\":10,\"x\":0,\"y\":8}"
      }

      layout_structure {
        key       = "panelPANE-FFC3EF32824EE84B"
        structure = "{\"height\":8,\"width\":4,\"x\":5,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel76223013B1B1CA45"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(ssl_cipher_suite_id)\n| count by ssl_cipher_suite_id, src_ip, dst_ip, app_name\n| sort by _count\n| limit 100"
        query_type   = "Logs"
      }

      title           = "Sessions flows using TLS Ciphers"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-1801CE7CB24E894F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(ssl_protocol_version)\n| if(ssl_protocol_version == 771, \"TLS1.2\",\n  if(ssl_protocol_version == 2, \"SSLv2\",\n  if(ssl_protocol_version == 768, \"SSLv3\",\n  if(ssl_protocol_version == 769, \"TLS1.0\",\n  if(ssl_protocol_version == 770, \"TLS1.1\",\n  if(ssl_protocol_version == 772, \"TLS1.3\",\n   ssl_protocol_version\n)))))) as version\n| count by version\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "TLS Versions seen in the network"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-31C5629CBCC98946"


      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(ssl_cipher_suite_id)\n| if(ssl_cipher_suite_id == 47, \"TLS_RSA_WITH_AES_128_CBC_SHA\",\n  if(ssl_cipher_suite_id == 49199, \"ECDHE-RSA-AES128-GCM-SHA256\",\n  if(ssl_cipher_suite_id == 49192, \"TLS_RSA_WITH_AES_128_CBC_SHA256\",\n  if(ssl_cipher_suite_id == 49200, \"TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384\",\n  if(ssl_cipher_suite_id == 49171, \"TLS_AES_256_GCM_SHA384\",\n  if(ssl_cipher_suite_id == 52393, \"TLS_RSA_WITH_AES_256_CBC_SHA256\",\n  if(ssl_cipher_suite_id == 50, \"TLS_DHE_DSS_WITH_AES_128_CBC_SHA\",\n  if(ssl_cipher_suite_id == 51, \"TLS_DHE_RSA_WITH_AES_128_CBC_SHA\",\n  if(ssl_cipher_suite_id == 52, \"TLS_DH_anon_WITH_AES_128_CBC_SHA\",\n  if(ssl_cipher_suite_id == 53, \"TLS_RSA_WITH_AES_256_CBC_SHA\",\n  if(ssl_cipher_suite_id == 56, \"TLS_DHE_DSS_WITH_AES_256_CBC_SHA\",\n  if(ssl_cipher_suite_id == 57, \"TLS_DHE_RSA_WITH_AES_256_CBC_SHA\",\n  if(ssl_cipher_suite_id == 58, \"TLS_DH_anon_WITH_AES_256_CBC_SHA\",\n  if(ssl_cipher_suite_id == 65, \"TLS_RSA_WITH_CAMELLIA_128_CBC_SHA\",\n  if(ssl_cipher_suite_id == 68, \"TLS_DHE_DSS_WITH_CAMELLIA_128_CBC_SHA\",\n  if(ssl_cipher_suite_id == 69, \"TLS_DHE_RSA_WITH_CAMELLIA_128_CBC_SHA\",\n  if(ssl_cipher_suite_id == 70, \"TLS_DH_anon_WITH_CAMELLIA_128_CBC_SHA\",\n  if(ssl_cipher_suite_id == 108, \"TLS_DH_anon_WITH_AES_128_CBC_SHA256\",\n  if(ssl_cipher_suite_id == 109, \"TLS_DH_anon_WITH_AES_256_CBC_SHA256\",\n  if(ssl_cipher_suite_id == 132, \"TLS_RSA_WITH_CAMELLIA_256_CBC_SHA\",\n  if(ssl_cipher_suite_id == 135, \"TLS_DHE_DSS_WITH_CAMELLIA_256_CBC_SHA\",\n  if(ssl_cipher_suite_id == 136, \"TLS_DHE_RSA_WITH_CAMELLIA_256_CBC_SHA\",\n  if(ssl_cipher_suite_id == 137, \"TLS_DH_anon_WITH_CAMELLIA_256_CBC_SHA\",\n  if(ssl_cipher_suite_id == 138, \"TLS_PSK_WITH_RC4_128_SHA\",\n  if(ssl_cipher_suite_id == 139, \"TLS_PSK_WITH_3DES_EDE_CBC_SHA\",\n  if(ssl_cipher_suite_id == 140, \"TLS_PSK_WITH_AES_128_CBC_SHA\",\n  if(ssl_cipher_suite_id == 141, \"TLS_PSK_WITH_AES_256_CBC_SHA\",\n  if(ssl_cipher_suite_id == 150, \"TLS_RSA_WITH_SEED_CBC_SHA\",\n  if(ssl_cipher_suite_id == 153, \"TLS_DHE_DSS_WITH_SEED_CBC_SHA\",\n  if(ssl_cipher_suite_id == 154, \"TLS_DHE_RSA_WITH_SEED_CBC_SHA\",\n  if(ssl_cipher_suite_id == 155, \"TLS_DH_anon_WITH_SEED_CBC_SHA\",\n  if(ssl_cipher_suite_id == 166, \"TLS_DH_anon_WITH_AES_128_GCM_SHA256\",\n  if(ssl_cipher_suite_id == 157, \"TLS_DH_anon_WITH_AES_256_GCM_SHA384\",\n  if(ssl_cipher_suite_id == 4865, \"TLS_AES_128_GCM_SHA256\",\n  if(ssl_cipher_suite_id == 4866, \"TLS_AES_256_GCM_SHA384\",\n  if(ssl_cipher_suite_id == 49172, \"TLS_DHE_RSA_WITH_AES_128_CBC_SHA256\",\n  if(ssl_cipher_suite_id == 49196, \"TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384\",\n  if(ssl_cipher_suite_id == 52392, \"TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256\",\n  ssl_cipher_suite_id\n)))))))))))))))))))))))))))))))))))))) as cipher_name\n| count by cipher_name\n| sort by _count\n| limit 100"
        query_type   = "Logs"
      }

      title           = "Weak Ciphers"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"overrides\":[{\"series\":[\"49172\"],\"queries\":[],\"properties\":{\"name\":\"TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256\"}},{\"series\":[\"49196\"],\"queries\":[],\"properties\":{\"name\":\"TLS_ECDHE_ECDSA_WITH_AES_256_ GCM_SHA384\"}}]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-3BC25FFDB8353B45"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(ssl_ext_sig_algorithm_scheme)\n| if(ssl_ext_sig_algorithm_scheme == 1537, \"rsa_pkcs1_sha512\",\n    if(ssl_ext_sig_algorithm_scheme == 1027, \"ecdsa_secp256r1_sha256\",\n    if(ssl_ext_sig_algorithm_scheme == 257, \"MD5 RSA\",\n    if(ssl_ext_sig_algorithm_scheme == 514, \"SHA1 DSA\",\n    if(ssl_ext_sig_algorithm_scheme == 515, \"ecdsa_sha1\",\n    if(ssl_ext_sig_algorithm_scheme == 769, \"SHA224 RSA\",\n    if(ssl_ext_sig_algorithm_scheme == 770, \"SHA224 DSA\",\n    if(ssl_ext_sig_algorithm_scheme == 771, \"SHA224 ECDSA\",\n    if(ssl_ext_sig_algorithm_scheme == 1025, \"rsa_pkcs1_sha256\",\n    if(ssl_ext_sig_algorithm_scheme == 1026, \"SHA256 DSA\",\n    if(ssl_ext_sig_algorithm_scheme == 1281, \"rsa_pkcs1_sha384\",\n    if(ssl_ext_sig_algorithm_scheme == 1282, \"SHA384 DSA\",\n    if(ssl_ext_sig_algorithm_scheme == 1283, \"ecdsa_secp384r1_sha384\",\n    if(ssl_ext_sig_algorithm_scheme == 1538, \"SHA512 DSA\",\n    if(ssl_ext_sig_algorithm_scheme == 1539, \"ecdsa_secp521r1_sha512\",\n    if(ssl_ext_sig_algorithm_scheme == 2052, \"rsa_pss_rsae_sha256\",\n    if(ssl_ext_sig_algorithm_scheme == 2053, \"rsa_pss_rsae_sha384\",\n    if(ssl_ext_sig_algorithm_scheme == 2054, \"rsa_pss_rsae_sha512\",\n    if(ssl_ext_sig_algorithm_scheme == 2055, \"ed25519\",\n    if(ssl_ext_sig_algorithm_scheme == 2056, \"ed448\",\n    if(ssl_ext_sig_algorithm_scheme == 2057, \"rsa_pss_pss_sha256\",\n    if(ssl_ext_sig_algorithm_scheme == 2058, \"rsa_pss_pss_sha384\",\n    if(ssl_ext_sig_algorithm_scheme == 2059, \"rsa_pss_pss_sha512\",\n    if(ssl_ext_sig_algorithm_scheme == 2570, \"GREASE\",\n    ssl_ext_sig_algorithm_scheme\n  )))))))))))))))))))))))) as Algorithm_Scheme\n| count by Algorithm_Scheme\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Signature_Algorithm"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-85268093ACE72840"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(http_content_encoding)\n| count by http_content_encoding\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Compression Algorithms detected"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-8BFC60BD968B784D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(ssl_protocol_version)\n| where ssl_protocol_version==\"SSL_3_0\" OR ssl_protocol_version==\"SSL_2_0\" OR ssl_protocol_version==\"TLS_1_0\" \n| count by ssl_protocol_version, src_ip, dst_ip, app_name\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Sessions using Old SSL Versions"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-94EB4163BDBBF844"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(http_content_encoding)\n| count by  src_ip, dst_ip, app_name,http_content_encoding\n| sort by _count\n|limit 100"
        query_type   = "Logs"
      }

      title           = "Sessions using compression algorithms"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-C2EF90B1A007B841"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(ssl_ext_sig_algorithm_sig)\n| if(ssl_ext_sig_algorithm_sig == 0, \"anonymous\",\n    if(ssl_ext_sig_algorithm_sig == 1, \"RSA\",\n    if(ssl_ext_sig_algorithm_sig == 2, \"DSA\",\n    if(ssl_ext_sig_algorithm_sig == 3, \"ECDSA\",\n    if(ssl_ext_sig_algorithm_sig == 769, \"DSA\",\n    ssl_ext_sig_algorithm_sig\n  ))))) as Algorithm_signature\n| count by Algorithm_signature\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Key Exchange Protocols seen on the network"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-FFC3EF32824EE84B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element|where !isNull(ssl_ext_sig_algorithm_hash)\n| if(ssl_ext_sig_algorithm_hash == 0, \"None\",\n  if(ssl_ext_sig_algorithm_hash == 1, \"MD5\",\n  if(ssl_ext_sig_algorithm_hash == 2, \"SHA1\",\n  if(ssl_ext_sig_algorithm_hash == 3, \"SHA224\",\n  if(ssl_ext_sig_algorithm_hash == 4, \"SHA256\",\n  if(ssl_ext_sig_algorithm_hash == 5, \"SHA384\",\n  if(ssl_ext_sig_algorithm_hash == 6, \"SHA512\",\n   ssl_ext_sig_algorithm_hash\n))))))) as Hash\n| count by Hash\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Cryptographic Hash"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"}}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "Security Posture - SSL Cryptographic details"
}

resource "sumologic_dashboard" "troubleshooting_insights_for_network_traffic" {
  description = "This dashboard helps to provide network traffic and latency details"
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
        key       = "panelPANE-1173CF39B123E94F"
        structure = "{\"height\":11,\"width\":8,\"x\":16,\"y\":31}"
      }

      layout_structure {
        key       = "panelPANE-2F534FB69F6EDB4A"
        structure = "{\"height\":8,\"width\":24,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-32B5A30094592A46"
        structure = "{\"height\":11,\"width\":9,\"x\":0,\"y\":32}"
      }

      layout_structure {
        key       = "panelPANE-5C003D2D8B492A46"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":25}"
      }

      layout_structure {
        key       = "panelPANE-64E4BD37938F7B4F"
        structure = "{\"height\":11,\"width\":7,\"x\":9,\"y\":32}"
      }

      layout_structure {
        key       = "panelPANE-73BCFB6FA66A3A43"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":8}"
      }

      layout_structure {
        key       = "panelPANE-809E7F09B20F5841"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":8}"
      }

      layout_structure {
        key       = "panelPANE-877BBDD98A9D0B49"
        structure = "{\"height\":11,\"width\":12,\"x\":12,\"y\":14}"
      }

      layout_structure {
        key       = "panelPANE-CBF17783ACB17841"
        structure = "{\"height\":7,\"width\":12,\"x\":0,\"y\":25}"
      }

      layout_structure {
        key       = "panelPANE-EE345B0EB8DB284E"
        structure = "{\"height\":11,\"width\":12,\"x\":0,\"y\":14}"
      }

      layout_structure {
        key       = "panelPANE-F934333B91F32A4A"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":43}"
      }

      layout_structure {
        key       = "panelPANE-FDA2DDF7B457694A"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":43}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-1173CF39B123E94F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name!=\"Unknown tcp\" \n  \u0026\u0026 app_name!=\"Unknown udp\" \n  \u0026\u0026 app_name!=\"Unknown ssl\" \n  \u0026\u0026 app_name!=\"Classification-unknown\" \n  \u0026\u0026 app_name!=\"\" \n  \u0026\u0026 tcp_loss_count!=\"\"\n| count by src_ip, dst_ip, app_name, tcp_loss_count\n"
        query_type   = "Logs"
      }

      title           = "Lost Data"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-2F534FB69F6EDB4A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(tcp_rtt_app) and tcp_rtt_app > 2\n| where app_name != \"Classification-unknown\" and app_name != \"Unknown tcp\" and app_name != \"Unknown udp\" and app_name != \"Unknown ssl\" and app_name != \"\"\n| avg(tcp_rtt_app) as Server_Latency by dst_ip\n| sort by Server_Latency desc\n| limit 10\n"
        query_type   = "Logs"
      }

      title           = "Top 10 worst performing Servers"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Light\"},\"series\":{},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-32B5A30094592A46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name!=\"Unknown tcp\" \u0026\u0026 app_name!=\"Unknown udp\" \u0026\u0026 app_name!=\"Unknown ssl\" \u0026\u0026 app_name!=\"Classification-unknown\" \u0026\u0026 app_name!=\"\" \u0026\u0026 ip_wrong_crc!=\"\"\n| src_ip as Client\n| dst_ip as Server\n| app_name as Application_Name\n| count by Client, Server, Application_Name\n"
        query_type   = "Logs"
      }

      title           = "IP CRC Checksum failure"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-5C003D2D8B492A46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(ip_wrong_crc) and ip_wrong_crc != \"\"\n| where app_name != \"Classification-unknown\" and app_name != \"Unknown tcp\" and app_name != \"Unknown udp\" and app_name != \"Unknown ssl\" and app_name != \"\"\n| timeslice 1m\n| count as Count by dst_ip, _timeslice\n| sort by Count desc\n| formatDate(_timeslice, \"HH:mm\") as Time\n"
        query_type   = "Logs"
      }

      title           = "IP CRC Trend"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-64E4BD37938F7B4F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where app_name!=\"Classification-unknown\"\n  \u0026\u0026 tcp_flags < 65\n  \u0026\u0026 tcp_flags != 0\n  \u0026\u0026 (\n    (tcp_flags < 24 and (tcp_flags % 8 in (4, 5, 6, 7)))\n    or x in (31, 36, 37, 39, 47, 63)\n  )\n| count by src_ip, dst_ip, tcp_flag_reset, app_name\n"
        query_type   = "Logs"
      }

      title           = "TCP Resets (aborts)"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-73BCFB6FA66A3A43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name!=\"Unknown tcp\" \n  \u0026\u0026 app_name!=\"Unknown udp\" \n  \u0026\u0026 app_name!=\"Unknown ssl\" \n  \u0026\u0026 app_name!=\"Classification-unknown\" \n  \u0026\u0026 app_name!=\"\" \n  \u0026\u0026 tcp_rtt!=\"\"\n| src_ip as Client\n| dst_ip as Server\n| app_name as Application_Name\n| count by Client, Server, Application_Name, tcp_rtt\n\n"
        query_type   = "Logs"
      }

      title           = "Network Latency"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-809E7F09B20F5841"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name!=\"Unknown tcp\" \n  \u0026\u0026 app_name!=\"Unknown udp\" \n  \u0026\u0026 app_name!=\"Unknown ssl\" \n  \u0026\u0026 app_name!=\"Classification-unknown\" \n  \u0026\u0026 app_name!=\"\" \n  \u0026\u0026 tcp_rtt_app>2\n| count by src_ip, dst_ip, app_name, tcp_rtt_app\n"
        query_type   = "Logs"
      }

      title           = "Server Latency"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-877BBDD98A9D0B49"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(tcp_rtt) and tcp_rtt > 1\n| timeslice 1m\n| avg(tcp_rtt) as Server_Latency by dst_ip,app_name, _timeslice\n| formatDate(_timeslice, \"HH:mm\") as Time\n| sort by Time\n"
        query_type   = "Logs"
      }

      title           = "Network Latency Trend"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"area\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"fillOpacity\":0.25,\"mode\":\"distribution\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-CBF17783ACB17841"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(tcp_loss_count) and tcp_loss_count != \"\"\n| where app_name != \"Classification-unknown\" and app_name != \"Unknown tcp\" and app_name != \"Unknown udp\" and app_name != \"Unknown ssl\" and app_name != \"\"\n| timeslice 1m\n| sum(tcp_loss_count) as Lost_Bytes by dst_ip, _timeslice\n| sort by Lost_Bytes desc\n| limit 10\n| formatDate(_timeslice, \"HH:mm\") as Time\n"
        query_type   = "Logs"
      }

      title           = "TCP Loss Count Trend"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-EE345B0EB8DB284E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(tcp_rtt_app) and tcp_rtt_app > 2\n| timeslice 1m\n| avg(tcp_rtt_app) as Server_Latency by dst_ip, _timeslice\n| formatDate(_timeslice, \"HH:mm\") as Time\n| sort by Time\n"
        query_type   = "Logs"
      }

      title           = "Server Latency Trend"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"area\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"triangle\",\"lineThickness\":1,\"fillOpacity\":0.25,\"mode\":\"distribution\"},\"xy\":{\"xDimension\":[],\"yDimension\":[],\"zDimension\":[]},\"color\":{\"family\":\"Categorical Light\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-F934333B91F32A4A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| count by dns_response_time\n| avg(_count)\n"
        query_type   = "Logs"
      }

      title           = "Average DNS Response time on the network"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"distribution\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-FDA2DDF7B457694A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| count by dns_response_time\n| avg(_count)\n"
        query_type   = "Logs"
      }

      title           = "Average Web response time"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"distribution\"},\"overrides\":[]}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "Troubleshooting Insights for Network Traffic"
}

resource "sumologic_dashboard" "troubleshooting_top_traffic_source_and_destinations" {
  description = "This dashboard helps user to troubleshoot the traffic Source and destination details."
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
        key       = "panelPANE-16A92435A7029A45"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-84A0AF52B0B90A40"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-BBA8647EABD5884A"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-C4AC26B783C14A43"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-DDEC05759C232A4D"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-DF79E4F998B4494A"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-16A92435A7029A45"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| count_distinct(dst_port)\n"
        query_type   = "Logs"
      }

      title           = "Distinct Destination Ports"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-84A0AF52B0B90A40"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where src_port > 0\n| count by src_port\n| sort by _count desc\n| limit 11\n"
        query_type   = "Logs"
      }

      title           = "Top Source ports"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-BBA8647EABD5884A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where dst_port > 0\n| count by dst_port\n| sort by _count desc\n| limit 11\n"
        query_type   = "Logs"
      }

      title           = "Top Destination ports"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-C4AC26B783C14A43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| count by src_ip\n| sort by _count desc\n| limit 10\n"
        query_type   = "Logs"
      }

      title           = "Top 10 traffic Sources"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-DDEC05759C232A4D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| count by dst_ip\n| sort by _count desc\n| limit 10\n"
        query_type   = "Logs"
      }

      title           = "Top 10 traffic Destinations"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-DF79E4F998B4494A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi\n| json auto field=element\n| where !isNull(src_port) and !isNull(app_name)\n| count_distinct(src_port)\n\n"
        query_type   = "Logs"
      }

      title           = "Distinct Source Ports"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true,\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#ffb0ee\"},\"gauge\":{\"show\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-1d"
        }
      }
    }
  }

  title = "Troubleshooting - Top Traffic Source and Destinations"
}
