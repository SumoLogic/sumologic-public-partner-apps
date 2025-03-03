resource "sumologic_dashboard" "tessian_architect" {
  description = "View stats and metrics related to Tessian Architect."
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
        key       = "panel0389A8B998F80A4C"
        structure = "{\"height\":10,\"width\":7,\"x\":7,\"y\":15,\"minHeight\":3,\"minWidth\":3}"
      }

      layout_structure {
        key       = "panel4B7AB10891CCDA4E"
        structure = "{\"height\":7,\"width\":7,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelFA5D0278A5E4C844"
        structure = "{\"height\":25,\"width\":5,\"x\":19,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-0A4FC934B407984D"
        structure = "{\"height\":8,\"width\":14,\"x\":0,\"y\":7}"
      }

      layout_structure {
        key       = "panelPANE-192F1BD6A13D9B4E"
        structure = "{\"height\":10,\"width\":7,\"x\":0,\"y\":15}"
      }

      layout_structure {
        key       = "panelPANE-3E9BF498909E9A40"
        structure = "{\"height\":7,\"width\":7,\"x\":7,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-49112418BBC59A4C"
        structure = "{\"height\":25,\"width\":5,\"x\":14,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-7D524B71AE11F943"
        structure = "{\"height\":10,\"width\":7,\"x\":7,\"y\":15}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel4B7AB10891CCDA4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"architect\"\n| json \"architect_details.final_outcome\" as final_outcome\n| where final_outcome = \"NOT_SENT\"\n| sort by id, updated_at\n| json \"outbound_email_details.message_id\" as message_id\n| transactionize id (merge message_id takeLast)\n| count_distinct(message_id)"
        query_type   = "Logs"
      }

      title           = "Flagged Emails - Email Was Not Sent"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"label\":\"Emails\",\"useBackgroundColor\":true,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":0,\"to\":9999999999,\"color\":\"#133059\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelFA5D0278A5E4C844"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"architect\"\n| json \"architect_details.triggered_policy_names\" as triggered_policies\n| sort by id, updated_at\n| replace(triggered_policies,\"[\\\"\", \"\") as triggered_policies\n| replace(triggered_policies,\"\\\"]\", \"\") as triggered_policies\n| tolowercase(replace(triggered_policies,\"_\", \" \")) as triggered_policies\n| transactionize id (merge triggered_policies takeLast)\n| count by triggered_policies\n| sum(_count) triggered_policies\n| sort by _sum desc\n| _sum as Flags\n| fields - _sum"
        query_type   = "Logs"
      }

      title           = "Top Triggering Filters"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\",\"decimals\":null},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-0A4FC934B407984D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"architect\"\n| json \"outbound_email_details.message_id\" as message_id\n| sort by id, updated_at\n| transactionize id (merge message_id takeLast)\n| timeslice 6h\n| count_distinct(message_id) as count _timeslice"
        query_type   = "Logs"
      }

      title           = "Architect Flagged Emails"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-192F1BD6A13D9B4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"architect\"\n| json \"outbound_email_details.message_id\" as message_id\n| sort by id, updated_at\n| json \"architect_details.final_outcome\" as final_outcome\n| toLowerCase(final_outcome) as final_outcome\n| replace(final_outcome, \"_\", \" \") as final_outcome\n| transactionize id (merge final_outcome takeLast, message_id takeLast)\n| count_distinct(message_id) by final_outcome\n| sum(_count_distinct) final_outcome"
        query_type   = "Logs"
      }

      title           = "Architect Final Outcome"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":0.8,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"color\":{\"family\":\"Categorical Default\"},\"legend\":{\"enabled\":false,\"showAsTable\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-3E9BF498909E9A40"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"architect\"\n| json \"outbound_email_details.message_id\" as message_id\n| sort by id, updated_at\n| transactionize id (merge message_id takeLast)\n| count_distinct(message_id)"
        query_type   = "Logs"
      }

      title           = "Total Emails Flagged"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"label\":\"Emails\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":0,\"to\":9999999999,\"color\":\"#007aff\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-49112418BBC59A4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"architect\"\n| json \"outbound_email_details.from\" as user\n| json \"outbound_email_details.message_id\" as message_id\n| sort by id, updated_at\n| transactionize id (merge user, message_id takeLast)\n| count_distinct(message_id) by user\n| sum(_count_distinct) user \n| sort by _sum desc\n| _sum as Flags\n| fields - _sum"
        query_type   = "Logs"
      }

      title           = "Highest Flagged Users"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-7D524B71AE11F943"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"architect\"\n| json \"architect_details.triggered_policy_names\" as triggered_policies\n| sort by id, updated_at\n| transactionize id (merge triggered_policies takeLast)\n| replace(triggered_policies,\"[\\\"\", \"\") as triggered_policies\n| replace(triggered_policies,\"\\\"]\", \"\") as triggered_policies\n| tolowercase(replace(triggered_policies,\"_\", \" \")) as triggered_policies\n| count by triggered_policies\n| sum(_count) triggered_policies"
        query_type   = "Logs"
      }

      title           = "Triggered Policies"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"color\":{\"family\":\"Categorical Default\"},\"legend\":{\"enabled\":false}}"
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

  title = "Tessian - Architect"
}

resource "sumologic_dashboard" "tessian_defender" {
  description = "View stats and metrics related to Tessian Defender."
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
        key       = "panel0B0D3384A077284B"
        structure = "{\"height\":10,\"width\":8,\"x\":14,\"y\":16}"
      }

      layout_structure {
        key       = "panel61FB4D1C94FE8B4D"
        structure = "{\"height\":7,\"width\":7,\"x\":7,\"y\":4}"
      }

      layout_structure {
        key       = "panelFA5D0278A5E4C844"
        structure = "{\"height\":15,\"width\":4,\"x\":18,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-0A4FC934B407984D"
        structure = "{\"height\":8,\"width\":14,\"x\":0,\"y\":8}"
      }

      layout_structure {
        key       = "panelPANE-192F1BD6A13D9B4E"
        structure = "{\"height\":10,\"width\":7,\"x\":0,\"y\":16}"
      }

      layout_structure {
        key       = "panelPANE-3E9BF498909E9A40"
        structure = "{\"height\":7,\"width\":7,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-49112418BBC59A4C"
        structure = "{\"height\":15,\"width\":4,\"x\":14,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-7D524B71AE11F943"
        structure = "{\"height\":10,\"width\":7,\"x\":7,\"y\":16}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel0B0D3384A077284B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"defender\"\n| json \"defender_details.intent_types\" as intent_types\n| sort by id, updated_at\n| transactionize id (merge intent_types takeLast)\n| replace(intent_types, \"[\", \"\") as intent_types\n| replace(intent_types, \"]\", \"\") as intent_types\n| parse regex field=intent_types \"\\\"(?<intent>.*?)\\\"\" multi\n| toLowerCase(intent) as intent\n| replace(intent, \"_\", \" \") as intent\n| count intent"
        query_type   = "Logs"
      }

      title           = "Defender Intent Types"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"color\":{\"family\":\"Diverging 2\"},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel61FB4D1C94FE8B4D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\", \"inbound_email_details.message_id\"\n| where type = \"defender\"\n| sort by id, updated_at\n| transactionize id (merge type takeLast)\n| count"
        query_type   = "Logs"
      }

      title           = "Total Warning Flags Seen by Users"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"label\":\"Warnings\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":0,\"to\":9999999999,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelFA5D0278A5E4C844"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"defender\"\n| json \"defender_details.impersonated_domain\" as impersonated_domain\n| where impersonated_domain != \"\"\n| where impersonated_domain != null\n| sort by id, updated_at\n| transactionize id (merge impersonated_domain takeLast)\n| count by impersonated_domain \n| sum(_count) by impersonated_domain\n| _sum as Flags\n| sort by _sum desc\n| fields - _sum"
        query_type   = "Logs"
      }

      title           = "Most Impersonated Domains"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-0A4FC934B407984D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"defender\"\n| json \"defender_details.confidence\" as confidence\n| toLowerCase(confidence) as confidence\n| replace(confidence, \"_\", \" \") as confidence\n| sort by id, updated_at\n| transactionize id (merge confidence takeLast)\n| timeslice 6h\n| count by confidence, _timeslice \n| transpose row _timeslice column confidence"
        query_type   = "Logs"
      }

      title           = "Event Severity"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Diverging 2\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-192F1BD6A13D9B4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"defender\"\n| json \"defender_details.users_responded.deleted\" as deleted\n| json \"defender_details.users_responded.malicious\" as malicious\n| json \"defender_details.users_responded.safe\" as safe\n| json \"defender_details.users_responded.unsure\" as unsure\n| sum(deleted) as deleted, sum(malicious) as malicious, sum(safe) as safe, sum(unsure) as unsure"
        query_type   = "Logs"
      }

      title           = "Defender Flagged Emails - User Interactions"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":0.8,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"color\":{\"family\":\"Diverging 2\"},\"legend\":{\"enabled\":false,\"showAsTable\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-3E9BF498909E9A40"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"defender\"\n| json \"inbound_email_details.message_id\" as message_id\n| sort by id, updated_at\n| transactionize id (merge message_id takeLast)\n| count_distinct(message_id)"
        query_type   = "Logs"
      }

      title           = "Unique Suspicious Emails Detected"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"label\":\"Emails\",\"useBackgroundColor\":true,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":0,\"to\":9999999999,\"color\":\"#442437\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-49112418BBC59A4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"defender\"\n| json \"inbound_email_details.recipients.to[0]\" as user\n| sort by id, updated_at\n| transactionize id (merge user takeLast)\n| count by user\n| sum(_count) by user\n| _sum as Flags\n| sort by _sum desc\n| fields - _sum"
        query_type   = "Logs"
      }

      title           = "Most Targeted Users"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-7D524B71AE11F943"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"defender\"\n| json \"defender_details.threat_types\" as threat_types\n| sort by id, updated_at\n| transactionize id (merge threat_types takeLast)\n| replace(threat_types,\"[\\\"\", \"\") as threat_types_replaced\n| replace(threat_types_replaced,\"\\\"]\", \"\") as threat_types_replaced\n| tolowercase(replace(threat_types_replaced,\"_\", \" \")) as threat_types_replaced\n| count by threat_types_replaced\n| sum(_count) threat_types_replaced"
        query_type   = "Logs"
      }

      title           = "Defender Threat Types"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"color\":{\"family\":\"Diverging 2\"},\"legend\":{\"enabled\":false}}"
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

  title = "Tessian - Defender"
}

resource "sumologic_dashboard" "tessian_guardian" {
  description = "View stats and metrics related to Tessian Guardian."
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
        key       = "panelF86248FC9792C84F"
        structure = "{\"height\":7,\"width\":7,\"x\":7,\"y\":2}"
      }

      layout_structure {
        key       = "panelFA5D0278A5E4C844"
        structure = "{\"height\":25,\"width\":4,\"x\":18,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-0A4FC934B407984D"
        structure = "{\"height\":8,\"width\":14,\"x\":0,\"y\":8}"
      }

      layout_structure {
        key       = "panelPANE-192F1BD6A13D9B4E"
        structure = "{\"height\":10,\"width\":7,\"x\":0,\"y\":16}"
      }

      layout_structure {
        key       = "panelPANE-3E9BF498909E9A40"
        structure = "{\"height\":7,\"width\":7,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-49112418BBC59A4C"
        structure = "{\"height\":25,\"width\":4,\"x\":14,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-7D524B71AE11F943"
        structure = "{\"height\":10,\"width\":7,\"x\":7,\"y\":16}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelF86248FC9792C84F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"guardian\"\n| json \"outbound_email_details.message_id\" as message_id\n| sort by id, updated_at\n| transactionize id (merge type, message_id takeLast)\n| count_distinct(message_id)"
        query_type   = "Logs"
      }

      title           = "Total Flags Shown"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"label\":\"Emails\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":0,\"to\":9999999999,\"color\":\"#05ae6b\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelFA5D0278A5E4C844"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"guardian\"\n| json \"guardian_details.breach_prevented\" as breach_prevented\n| where breach_prevented = \"true\"\n| json \"outbound_email_details.message_id\" as message_id\n| sort by id, updated_at\n| json \"outbound_email_details.from\" as user\n| transactionize id (merge user takeLast, message_id takeLast)\n| count_distinct(message_id) by user\n| sum(_count_distinct) user \n| sort by _sum desc\n| _sum as Flags\n| fields - _sum"
        query_type   = "Logs"
      }

      title           = "Most Misdirected Emails Prevented"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\",\"decimals\":null},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-0A4FC934B407984D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"guardian\"\n| json \"outbound_email_details.message_id\" as message_id\n| sort by id, updated_at\n| transactionize id (merge message_id takeLast)\n| timeslice 6h\n| count_distinct(message_id) as count _timeslice"
        query_type   = "Logs"
      }

      title           = "Misdirected Emails Flags"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Light\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-192F1BD6A13D9B4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"guardian\"\n| json \"outbound_email_details.message_id\" as message_id\n| sort by id, updated_at\n| json \"guardian_details.final_outcome\" as final_outcome\n| toLowerCase(final_outcome) as final_outcome\n| replace(final_outcome, \"_\", \" \") as final_outcome\n| transactionize id (merge final_outcome takeLast, message_id takeLast)\n| count_distinct(message_id) by final_outcome\n| sum(_count_distinct) final_outcome"
        query_type   = "Logs"
      }

      title           = "Final Outcome"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":0.8,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"color\":{\"family\":\"Categorical Light\"},\"legend\":{\"enabled\":false,\"showAsTable\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-3E9BF498909E9A40"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"guardian\"\n| json \"guardian_details.breach_prevented\" as breach_prevented\n| where breach_prevented = \"true\"\n| sort by id, updated_at\n| json \"outbound_email_details.message_id\" as message_id\n| transactionize id (merge type, message_id takeLast)\n| count_distinct(message_id)"
        query_type   = "Logs"
      }

      title           = "Misdirected Emails Prevented"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"label\":\"Emails\",\"useBackgroundColor\":true,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":0,\"to\":9999999999,\"color\":\"#144a44\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-49112418BBC59A4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"guardian\"\n| sort by id, updated_at\n| json \"outbound_email_details.from\" as user\n| json \"outbound_email_details.message_id\" as message_id\n| transactionize id (merge user takeLast, message_id takeLast)\n| count_distinct(message_id) by user\n| sum(_count_distinct) user \n| sort by _sum desc\n| _sum as Flags\n| fields - _sum"
        query_type   = "Logs"
      }

      title           = "Most Guardian Flags"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-7D524B71AE11F943"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"guardian\"\n| json \"guardian_details.type\" as event_type\n| sort by id, updated_at\n| transactionize id (merge event_type takeLast)\n| replace(event_type,\"[\\\"\", \"\") as event_type\n| replace(event_type,\"\\\"]\", \"\") as event_type\n| tolowercase(replace(event_type,\"_\", \" \")) as event_type\n| count by event_type\n| sum(_count) event_type"
        query_type   = "Logs"
      }

      title           = "Event Type"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"color\":{\"family\":\"Categorical Light\"},\"legend\":{\"enabled\":false}}"
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

  title = "Tessian - Guardian"
}

resource "sumologic_dashboard" "tessian_overview" {
  description = "View top level stats and metrics related to all Tessian modules."
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
        key       = "panel1DCA7D5A8868CA4E"
        structure = "{\"height\":6,\"width\":4,\"x\":4,\"y\":8}"
      }

      layout_structure {
        key       = "panel3B74F4E9A0207A46"
        structure = "{\"height\":6,\"width\":4,\"x\":0,\"y\":20}"
      }

      layout_structure {
        key       = "panel5EFFD16797A67B43"
        structure = "{\"height\":2,\"width\":16,\"x\":8,\"y\":0}"
      }

      layout_structure {
        key       = "panel63EB9FBFA1C1B843"
        structure = "{\"height\":6,\"width\":16,\"x\":8,\"y\":8}"
      }

      layout_structure {
        key       = "panel7C845A44A94D5A4E"
        structure = "{\"height\":6,\"width\":4,\"x\":4,\"y\":2}"
      }

      layout_structure {
        key       = "panel87248F538F75B947"
        structure = "{\"height\":2,\"width\":4,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelBB7A4D3DB8078940"
        structure = "{\"height\":6,\"width\":4,\"x\":0,\"y\":8}"
      }

      layout_structure {
        key       = "panelE7EBCBB6ABDDEB4F"
        structure = "{\"height\":6,\"width\":4,\"x\":4,\"y\":21}"
      }

      layout_structure {
        key       = "panelF1D1536FB30F5A4F"
        structure = "{\"height\":6,\"width\":16,\"x\":8,\"y\":20}"
      }

      layout_structure {
        key       = "panelPANE-547783169694994B"
        structure = "{\"height\":6,\"width\":16,\"x\":8,\"y\":2}"
      }

      layout_structure {
        key       = "panelPANE-8F6ADF1F9A7C0B43"
        structure = "{\"height\":6,\"width\":4,\"x\":0,\"y\":2}"
      }

      layout_structure {
        key       = "panelPANE-FE4BE76C822C5A4B"
        structure = "{\"height\":2,\"width\":4,\"x\":4,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel1DCA7D5A8868CA4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"guardian\"\n| json \"guardian_details.breach_prevented\" as breach_prevented\n| where breach_prevented = \"true\"\n| json \"outbound_email_details.message_id\" as message_id\n| sort by id, updated_at\n| transactionize id (merge message_id takeLast)\n| count_distinct(message_id)"
        query_type   = "Logs"
      }

      title           = "Misdirected  Emails Prevented (Guardian)"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"label\":\"Emails\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":0,\"to\":9999999999,\"color\":\"#05ae6b\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel3B74F4E9A0207A46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"architect\"\n| sort by id, updated_at\n| json \"outbound_email_details.message_id\" as message_id\n| transactionize id (merge message_id takeLast)\n| count_distinct(message_id)"
        query_type   = "Logs"
      }

      time_range {
        begin_bounded_time_range {
          from {
            literal_time_range {
              range_name = "today"
            }
          }
        }
      }

      title           = "Emails Flagged (Architect)"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"label\":\"Emails\",\"useBackgroundColor\":true,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":0,\"to\":9999999999,\"color\":\"#133059\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel63EB9FBFA1C1B843"


      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"guardian\"\n| json \"guardian_details.breach_prevented\" as breach_prevented\n| where breach_prevented = \"true\"\n| sort by id, updated_at\n| json \"outbound_email_details.message_id\" as message_id\n| transactionize id(merge type takeLast, message_id takeLast)\n| timeslice 6h\n| count_distinct(message_id) by type, _timeslice \n| transpose row _timeslice column type"
        query_type   = "Logs"
      }

      title           = "Misdirected Emails Flagged"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Light\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel7C845A44A94D5A4E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\", \"inbound_email_details.message_id\"\n|where type = \"defender\"\n| sort by id, updated_at\n| transactionize id (merge type takeLast)\n| count"
        query_type   = "Logs"
      }

      title           = "Suspicious Emails Detected (Defender)"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"label\":\"Emails\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":0,\"to\":9999999999,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelBB7A4D3DB8078940"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"guardian\"\n| sort by id, updated_at\n| json \"outbound_email_details.message_id\" as message_id\n| transactionize id (merge message_id takeLast)\n| count_distinct(message_id)"
        query_type   = "Logs"
      }

      time_range {
        begin_bounded_time_range {
          from {
            literal_time_range {
              range_name = "today"
            }
          }
        }
      }

      title           = "Misdirected  Emails Prevented (Guardian)"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"label\":\"Emails\",\"useBackgroundColor\":true,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":0,\"to\":9999999999,\"color\":\"#144a44\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelE7EBCBB6ABDDEB4F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"architect\"\n| sort by id, updated_at\n| json \"outbound_email_details.message_id\" as message_id\n| transactionize id (merge message_id takeLast)\n| count_distinct(message_id)"
        query_type   = "Logs"
      }

      title           = "Emails Flagged (Architect)"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"label\":\"Emails\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":0,\"to\":9999999999,\"color\":\"#007aff\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelF1D1536FB30F5A4F"


      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"architect\"\n| sort by id, updated_at\n| json \"outbound_email_details.message_id\" as message_id\n| transactionize id (merge message_id takeLast)\n| timeslice 6h\n| count_distinct(message_id) as count _timeslice"
        query_type   = "Logs"
      }

      title           = "Architect Flags"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-547783169694994B"


      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\", \"inbound_email_details.message_id\"\n| where type = \"defender\"\n| sort by id, updated_at\n| transactionize id (merge type takeLast)\n| timeslice 6h\n| count by type, _timeslice \n| transpose row _timeslice column type"
        query_type   = "Logs"
      }

      title           = "Suspicious Emails Detected"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Diverging 2\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-8F6ADF1F9A7C0B43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| json field=_raw \"type\", \"id\", \"updated_at\"\n| where type = \"defender\"\n| sort by id, updated_at\n| json \"inbound_email_details.message_id\" as message_id\n| transactionize id (merge message_id takeLast)\n| count_distinct(message_id)"
        query_type   = "Logs"
      }

      time_range {
        begin_bounded_time_range {
          from {
            literal_time_range {
              range_name = "today"
            }
          }
        }
      }

      title           = "Suspicious Emails Detected (Defender)"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Sum\",\"label\":\"Emails\",\"useBackgroundColor\":true,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":0,\"to\":9999999999,\"color\":\"#442437\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel5EFFD16797A67B43"
      text                                        = "## Events Over Dashboard Period"
      title                                       = "Tessian"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"text\":{\"format\":\"markdownV2\",\"verticalAlignment\":\"center\",\"horizontalAlignment\":\"center\"},\"series\":{},\"title\":{\"fontSize\":15},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel87248F538F75B947"
      text                                        = "## Today"
      title                                       = "Tessian"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"text\":{\"format\":\"markdownV2\",\"verticalAlignment\":\"center\",\"horizontalAlignment\":\"center\"},\"series\":{},\"title\":{\"fontSize\":15},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-FE4BE76C822C5A4B"
      text                                        = "## Dashboard Period"
      title                                       = "Tessian"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"text\":{\"format\":\"markdownV2\",\"verticalAlignment\":\"center\",\"horizontalAlignment\":\"center\",\"backgroundColor\":\"#151e30\",\"textColor\":\"#ffffff\"},\"series\":{},\"title\":{\"fontSize\":15},\"legend\":{\"enabled\":false}}"
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

  title = "Tessian - Overview"
}
