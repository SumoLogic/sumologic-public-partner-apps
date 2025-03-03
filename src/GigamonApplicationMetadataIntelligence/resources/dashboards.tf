resource "sumologic_dashboard" "gigamon_deep_observability_pipeline_ami_overview" {
  description = "The Gigamon Deep Observability Pipeline efficiently delivers network-derived intelligence to amplify the power of your cloud, security, and observability tools. The solution eliminates network blind spots as you move workloads to the cloud, reducing security, and compliance risks while improving performance across your hybrid cloud infrastructure."
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
        key       = "panel01D74099928DA842"
        structure = "{\"height\":8,\"width\":12,\"x\":12,\"y\":26}"
      }

      layout_structure {
        key       = "panel14FDAB9EAEFA6A4B"
        structure = "{\"height\":8,\"width\":12,\"x\":12,\"y\":34}"
      }

      layout_structure {
        key       = "panel6A04F39DB464AB44"
        structure = "{\"height\":12,\"width\":12,\"x\":12,\"y\":14}"
      }

      layout_structure {
        key       = "panel6D540DA0BA020A41"
        structure = "{\"height\":14,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panel7D95EB099675CB40"
        structure = "{\"height\":8,\"width\":12,\"x\":0,\"y\":34}"
      }

      layout_structure {
        key       = "panel8A8959EAAB922A4A"
        structure = "{\"height\":12,\"width\":12,\"x\":0,\"y\":14}"
      }

      layout_structure {
        key       = "panel90E2509C86AF9841"
        structure = "{\"height\":8,\"width\":12,\"x\":0,\"y\":26}"
      }

      layout_structure {
        key       = "panel91288E9FA5F8CA45"
        structure = "{\"height\":14,\"width\":12,\"x\":0,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel01D74099928DA842"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(smb_filename)\n| count by smb_filename,smb_path,src_ip,dst_ip"
        query_type   = "Logs"
      }

      title           = "SMB File Movement"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel14FDAB9EAEFA6A4B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(http_code)\n| count by http_code | sort by _count"
        query_type   = "Logs"
      }

      title           = "HTTP Response Codes"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"bar\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel6A04F39DB464AB44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(ssl_validity_not_before)\n| count by ssl_validity_not_before,src_ip,ssl_common_name,ssl_protocol_version,ssl_issuer\n| sort by ssl_validity_not_before asc"
        query_type   = "Logs"
      }

      title           = "SSL Certificates Validity"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel6D540DA0BA020A41"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where app_name matches \"*mine*\" OR app_name matches \"*torrent\" OR app_name matches \"*coin*\"\n| count by app_name,src_ip"
        query_type   = "Logs"
      }

      title           = "Suspicious Traffic"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel7D95EB099675CB40"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(dhcp_host_name)\n| where dhcp_message_type = \"DHCPINFORM\"\n| count by dhcp_host_name,dhcp_ciaddr\n| sort by _count\n| limit 25"
        query_type   = "Logs"
      }

      title           = "Top 25 DHCP IP \u0026 Hostnames"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\",\"paginationPageSize\":20},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8A8959EAAB922A4A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(ssl_cipher_suite_id_string)\n| count as count by ssl_cipher_suite_id_string\n| sort by count"
        query_type   = "Logs"
      }

      title           = "SSL Ciphers in Use"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel90E2509C86AF9841"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json auto field=element\n| where !isNull(dns_query)\n| where isPublicIP(dst_ip)\n| count by src_ip,dns_query,dst_ip\n| sort by _count\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 DNS Queries"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel91288E9FA5F8CA45"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| parse regex \"(?<element>\\{\\\"\\w.*?\\\"[^\\}]+\\})\" multi \n| json field=element \"app_name\" as app_name\n| count by app_name"
        query_type   = "Logs"
      }

      title           = "Application Overview"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"innerRadius\":\"50%\"},\"series\":{}}"
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

  title = "Gigamon Deep Observability Pipeline - AMI - Overview"
}
