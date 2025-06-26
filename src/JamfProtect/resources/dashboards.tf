resource "sumologic_dashboard" "jamf_protect_alerts_overview" {
  description = "Overview of events from Alerts \u0026 Unified Logs"
  folder_id   = sumologic_folder.jamf_protect_folder.id

  variable {
    allow_multi_select = "false"
    default_value      = var.default_scope_value1
    display_name = var.scope_key1_variable_display_name
    hide_from_ui       = "false"
    include_all_option = "true"
    name = var.scope_key1_variable_display_name
    source_definition {
      csv_variable_source_definition {
        values = "${var.default_scope_value1}"
      }
    }
  }

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
        key       = "panel3BD6421AABFC984E"
        structure = "{\"height\":5,\"width\":8,\"x\":8,\"y\":2}"
      }

      layout_structure {
        key       = "panel9DCEA3D99A14F848"
        structure = "{\"height\":5,\"width\":8,\"x\":16,\"y\":2}"
      }

      layout_structure {
        key       = "panelPANE-21B40D0593ACDA4A"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":23}"
      }

      layout_structure {
        key       = "panelPANE-25D612C293CFB849"
        structure = "{\"height\":2,\"width\":24,\"x\":0,\"y\":47}"
      }

      layout_structure {
        key       = "panelPANE-335BAE3392735B40"
        structure = "{\"height\":9,\"width\":24,\"x\":0,\"y\":49}"
      }

      layout_structure {
        key       = "panelPANE-39F6A2B387749948"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":17}"
      }

      layout_structure {
        key       = "panelPANE-4CC3F8C2839A794B"
        structure = "{\"height\":10,\"width\":24,\"x\":0,\"y\":7}"
      }

      layout_structure {
        key       = "panelPANE-59FE52AAB0165B4C"
        structure = "{\"height\":7,\"width\":16,\"x\":8,\"y\":40}"
      }

      layout_structure {
        key       = "panelPANE-5DAF3D7B8A13194B"
        structure = "{\"height\":5,\"width\":8,\"x\":0,\"y\":2}"
      }

      layout_structure {
        key       = "panelPANE-7768572187238A45"
        structure = "{\"height\":2,\"width\":24,\"x\":0,\"y\":38}"
      }

      layout_structure {
        key       = "panelPANE-778A778892823845"
        structure = "{\"height\":9,\"width\":12,\"x\":0,\"y\":29}"
      }

      layout_structure {
        key       = "panelPANE-87D19A9DA4785B40"
        structure = "{\"height\":2,\"width\":24,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-948838ECA45E684E"
        structure = "{\"height\":6,\"width\":11,\"x\":0,\"y\":58}"
      }

      layout_structure {
        key       = "panelPANE-97996539BD852B45"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":17}"
      }

      layout_structure {
        key       = "panelPANE-A017C4C68F6A2B45"
        structure = "{\"height\":9,\"width\":12,\"x\":12,\"y\":29}"
      }

      layout_structure {
        key       = "panelPANE-A6C23141A0083B47"
        structure = "{\"height\":7,\"width\":8,\"x\":0,\"y\":40}"
      }

      layout_structure {
        key       = "panelPANE-C4A71009B0444B41"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":23}"
      }

      layout_structure {
        key       = "panelPANE-EF7230839FBA0945"
        structure = "{\"height\":6,\"width\":13,\"x\":11,\"y\":58}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel3BD6421AABFC984E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   caid\n| json \"input.match.severity\" as severity\n| json \"input.host.hostname\" as hostname\n| where hostname matches \"{{hostname}}\"\n| where severity = 2\n| dedup %\"input.match.uuid\"\n| count by severity"
        query_type   = "Logs"
      }

      title           = "Medium"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"label\":\"Alerts\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":50,\"labelFontSize\":10,\"thresholds\":[{\"from\":0,\"to\":100,\"color\":\"#f0731f\"},{\"from\":null,\"to\":null,\"color\":\"#f0731f\"},{\"from\":null,\"to\":null,\"color\":\"#f0731f\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel9DCEA3D99A14F848"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   caid\n| json \"input.match.severity\" as severity\n| json \"input.host.hostname\" as hostname\n| where hostname matches \"{{hostname}}\"\n| where severity = 1\n| dedup %\"input.match.uuid\"\n| count by severity"
        query_type   = "Logs"
      }

      title           = "Low"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"label\":\"Alerts\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":50,\"labelFontSize\":10,\"thresholds\":[{\"from\":0,\"to\":100,\"color\":\"#f2da73\"},{\"from\":null,\"to\":null,\"color\":\"#f2da73\"},{\"from\":null,\"to\":null,\"color\":\"#f2da73\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-21B40D0593ACDA4A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   caid\nAND GPThreatMatchExecEvent\n| json \"input.eventType\",\"input.match.event.matchValue\",\"input.host.hostname\" as eventType,threat,hostname\n| where hostname matches \"{{hostname}}\"\n| dedup %\"input.match.uuid\"\n| count threat\n \n"
        query_type   = "Logs"
      }

      title           = "Threat Prevention Signatures"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-335BAE3392735B40"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  \nGPUnifiedLogEvent) \nAND \"com.apple.XProtectFramework.PluginAPI\"\n| timeslice 1d\n| json \"input.host.hostname\",\"input.match.event.composedMessage\", \"input.match.event.process\" as hostname,event,module\n| where hostname matches \"{{hostname}}\"\n| parse regex field=Event \"status_message\\\"\\:\\\"(?<Status>[a-zA-Z\\W]+)\\\"\\,\"\n| parse regex field=Event \"execution_duration\\\"\\:(?<Duration>[\\d+\\W\\w]+)\\}\"\n| dedup %\"input.match.uuid\"\n| count by _timeslice, hostname, module, status, duration\n| fields - _count\n| sort by _timeslice"
        query_type   = "Logs"
      }

      title           = "XProtect Remediator Scan Activity"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"paginationPageSize\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-39F6A2B387749948"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   caid\n| timeslice 1d\n| json \"input.host.hostname\" as hostname\n| where hostname matches \"{{hostname}}\"\n| where %\"input.match.severity\" > 0\n| dedup %\"input.match.uuid\"\n| count by _timeslice"
        query_type   = "Logs"
      }

      title           = "Total Events Detected"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\" \",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"hideLabels\":false}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"},\"xy\":{\"xDimension\":[],\"yDimension\":[],\"zDimension\":[]},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-4CC3F8C2839A794B"

      query {
        query_key    = "A"
        query_string = "((${var.scope_key}={{${var.scope_key_variable_display_name}}}  ) caid)\n| formatDate(_messagetime, \"yyyy-MM-dd HH:mm:ss\", \"etc/utc\") as time\n| json field=_raw \"input.host.hostname\", \"input.match.severity\", \"input.eventType\", \"input.match.facts[0].human\" as hostname, severity, eventType, description\n| where hostname matches \"{{hostname}}\"\n| where severity > 0\n| dedup %\"input.match.uuid\"\n| if (%\"input.match.actions[0].name\" matches \"Prevented\", \"Blocked\",\nif (%\"input.match.actions[1].name\" matches \"Prevented\", \"Blocked\",\nif (%\"input.match.actions[2].name\" matches \"Prevented\", \"Blocked\",\nif (%\"input.match.facts[0].name\" matches \"XProtectDetection\", \"Blocked\", \nif (%\"input.match.facts[0].name\" matches \"GatekeeperBlocked*\", \"Blocked\", \"Allowed\"))))) as action\n| if (!isNull(%\"input.match.event.matchValue\"), %\"input.match.event.matchValue\",\nif (!isNull(%\"input.match.facts[2].name\"), concat(%\"input.match.facts[2].name\",\"\\n\",%\"input.match.facts[1].name\",\"\\n\",%\"input.match.facts[0].name\"),\nif (!isNull(%\"input.match.facts[1].name\"), concat(%\"input.match.facts[1].name\",\"\\n\" ,%\"input.match.facts[0].name\"),\nif (!isNull(%\"input.match.facts[0].name\"), %\"input.match.facts[0].name\",\"unknown\")))) as signature\n| if (!isNull(%\"input.match.facts[2].human\"), concat(%\"input.match.facts[2].human\",\"\\n\",%\"input.match.facts[1].human\",\"\\n\",%\"input.match.facts[0].human\"),\nif (!isNull(%\"input.match.facts[1].human\"), concat(%\"input.match.facts[1].human\",\"\\n\",%\"input.match.facts[0].human\"),\nif (!isNull(%\"input.match.facts[0].human\"), %\"input.match.facts[0].human\",\"unknown\"))) as description\n| replace(severity,\"3\",\"High\") as severity\n| replace(severity,\"2\",\"Medium\") as severity\n| replace(severity,\"1\",\"Low\") as severity\n| count time, action, hostname, signature, description, severity\n| sort by time\n| fields -_count\n\n"
        query_type   = "Logs"
      }

      title           = "Most Recent Alerts"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-59FE52AAB0165B4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   caid\nauth-mount\n| json \"input.host.hostname\", \"input.match.event.device.vendorName\", \"input.match.event.device.productName\", \"input.match.event.device.productId\", \"input.match.event.device.isEncrypted\" as Hostname, Vendor, Name, ProductId,\n Encrpytion_Status\n| where hostname matches \"{{hostname}}\"\n| concat (Vendor, \" \",Name) as Device\n| count Hostname, Device\n| order by _count"
        query_type   = "Logs"
      }

      title           = "Endpoint Information"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\",\"paginationPageSize\":10},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-5DAF3D7B8A13194B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   caid\n| json \"input.match.severity\" as severity\n| json \"input.host.hostname\" as hostname\n| where hostname matches \"{{hostname}}\"\n| where severity = 3\n| dedup %\"input.match.uuid\"\n| count by severity"
        query_type   = "Logs"
      }

      title           = "High"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"label\":\"Alert\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":50,\"labelFontSize\":10,\"thresholds\":[{\"from\":0,\"to\":100,\"color\":\"#bf2121\"},{\"from\":null,\"to\":null,\"color\":\"#bf2121\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-778A778892823845"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   caid\n| json \"input.eventType\", \"input.match.facts[0].name\",\"input.host.hostname\" as eventtype,event,hostname\n| where hostname matches \"{{hostname}}\"\n| where eventType != \"GPUnifiedLogEvent\"\n| dedup %\"input.match.uuid\"\n| if (!isNull(%\"input.match.facts[2].name\"), concat(%\"input.match.facts[2].name\",\"\\n\",%\"input.match.facts[1].name\",\"\\n\",%\"input.match.facts[0].name\"),\nif (!isNull(%\"input.match.facts[1].name\"), concat(%\"input.match.facts[1].name\",\"\\n\" ,%\"input.match.facts[0].name\"),\nif (!isNull(%\"input.match.facts[0].name\"), %\"input.match.facts[0].name\",\"unknown\"))) as event\n| count eventType,event\n| order by _count desc \n| top 10 eventType, event by _count\n"
        query_type   = "Logs"
      }

      title           = "Event Counts (Top 10)"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\",\"paginationPageSize\":10},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-948838ECA45E684E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   caid\nGPGatekeeperEvent\n| json \"input.eventType\",\"input.match.facts[0].name\" as eventType,event\n| json \"input.host.hostname\" as hostname\n| where hostname matches \"{{hostname}}\"\n| count event\n \n"
        query_type   = "Logs"
      }

      title           = "Gatekeeper Event Types"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\"},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-97996539BD852B45"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   caid\n| timeslice 1d\n| json \"input.match.severity\" as severity\n| json \"input.host.hostname\" as hostname\n| where hostname matches \"{{hostname}}\"\n| where severity>0\n| dedup %\"input.match.uuid\"\n| replace(severity,\"3\",\"High\") as severity\n| replace(severity,\"2\",\"Medium\") as severity\n| replace(severity,\"1\",\"Low\") as severity\n| count _timeslice, severity\n| transpose row _timeslice column severity"
        query_type   = "Logs"
      }

      title           = "Events Detected (Count by Severity)"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"area\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null,\"legend\":{\"position\":\"right\",\"enabled\":true},\"xAxis\":{\"title\":\"\",\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":\"\",\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{\"GPFSEvent\":{\"yAxis\":0,\"color\":\"#37B067\"},\"GPGatekeeperEvent\":{\"yAxis\":0,\"color\":\"#6296BC\"},\"GPPreventedExecutionEvent\":{\"yAxis\":0,\"color\":\"#EDB40D\"},\"GPProcessEvent\":{\"yAxis\":0,\"color\":\"#7FD7C1\"},\"GPThreatMatchExecEvent\":{\"yAxis\":0,\"color\":\"#EB6672\"},\"GPUnifiedLogEvent\":{\"yAxis\":0,\"color\":\"#E3791A\"},\"auth-mount\":{\"yAxis\":0,\"color\":\"#EE9DCC\"}}}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"position\":\"right\",\"enabled\":true},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":\"\",\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":\"\",\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{\"GPFSEvent\":{\"yAxis\":0,\"color\":\"#37B067\"},\"GPGatekeeperEvent\":{\"yAxis\":0,\"color\":\"#6296BC\"},\"GPPreventedExecutionEvent\":{\"yAxis\":0,\"color\":\"#EDB40D\"},\"GPProcessEvent\":{\"yAxis\":0,\"color\":\"#7FD7C1\"},\"GPThreatMatchExecEvent\":{\"yAxis\":0,\"color\":\"#EB6672\"},\"GPUnifiedLogEvent\":{\"yAxis\":0,\"color\":\"#E3791A\"},\"auth-mount\":{\"yAxis\":0,\"color\":\"#EE9DCC\"}},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"position\":\"right\",\"enabled\":true},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":\"\",\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":\"\",\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{\"GPFSEvent\":{\"yAxis\":0,\"color\":\"#37B067\"},\"GPGatekeeperEvent\":{\"yAxis\":0,\"color\":\"#6296BC\"},\"GPPreventedExecutionEvent\":{\"yAxis\":0,\"color\":\"#EDB40D\"},\"GPProcessEvent\":{\"yAxis\":0,\"color\":\"#7FD7C1\"},\"GPThreatMatchExecEvent\":{\"yAxis\":0,\"color\":\"#EB6672\"},\"GPUnifiedLogEvent\":{\"yAxis\":0,\"color\":\"#E3791A\"},\"auth-mount\":{\"yAxis\":0,\"color\":\"#EE9DCC\"}},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"position\":\"right\",\"enabled\":true},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":\"\",\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":\"\",\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{\"GPFSEvent\":{\"yAxis\":0,\"color\":\"#37B067\"},\"GPGatekeeperEvent\":{\"yAxis\":0,\"color\":\"#6296BC\"},\"GPPreventedExecutionEvent\":{\"yAxis\":0,\"color\":\"#EDB40D\"},\"GPProcessEvent\":{\"yAxis\":0,\"color\":\"#7FD7C1\"},\"GPThreatMatchExecEvent\":{\"yAxis\":0,\"color\":\"#EB6672\"},\"GPUnifiedLogEvent\":{\"yAxis\":0,\"color\":\"#E3791A\"},\"auth-mount\":{\"yAxis\":0,\"color\":\"#EE9DCC\"}},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"position\":\"right\",\"enabled\":true},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":\"\",\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":\"\",\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{\"GPFSEvent\":{\"yAxis\":0,\"color\":\"#37B067\"},\"GPGatekeeperEvent\":{\"yAxis\":0,\"color\":\"#6296BC\"},\"GPPreventedExecutionEvent\":{\"yAxis\":0,\"color\":\"#EDB40D\"},\"GPProcessEvent\":{\"yAxis\":0,\"color\":\"#7FD7C1\"},\"GPThreatMatchExecEvent\":{\"yAxis\":0,\"color\":\"#EB6672\"},\"GPUnifiedLogEvent\":{\"yAxis\":0,\"color\":\"#E3791A\"},\"auth-mount\":{\"yAxis\":0,\"color\":\"#EE9DCC\"}},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\",\"legend\":{\"position\":\"right\",\"enabled\":true},\"xAxis\":{\"title\":\"\",\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":\"\",\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{\"GPFSEvent\":{\"yAxis\":0,\"color\":\"#37B067\"},\"GPGatekeeperEvent\":{\"yAxis\":0,\"color\":\"#6296BC\"},\"GPPreventedExecutionEvent\":{\"yAxis\":0,\"color\":\"#EDB40D\"},\"GPProcessEvent\":{\"yAxis\":0,\"color\":\"#7FD7C1\"},\"GPThreatMatchExecEvent\":{\"yAxis\":0,\"color\":\"#EB6672\"},\"GPUnifiedLogEvent\":{\"yAxis\":0,\"color\":\"#E3791A\"},\"auth-mount\":{\"yAxis\":0,\"color\":\"#EE9DCC\"}}}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"showAsTable\":true},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-A017C4C68F6A2B45"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   caid\n| json \"input.host.hostname\" as Hostname\n| where hostname matches \"{{hostname}}\"\n| where %\"input.match.severity\" > 0\n| dedup %\"input.match.uuid\"\n| count Hostname\n| sort by _count"
        query_type   = "Logs"
      }

      title           = "Most Active Endpoints"
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-A6C23141A0083B47"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   caid\nauth-mount  \n| json field=_raw \"input.match.facts[1].name\",\"input.host.hostname\" as detection_name,hostname\n| where detection_name = \"EnforcedRemovableDevicePolicy\"\n| where hostname matches \"{{hostname}}\"\n| dedup %\"input.match.uuid\"\n| count by detection_name"
        query_type   = "Logs"
      }

      title           = "Devices Blocked"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":50,\"labelFontSize\":14,\"thresholds\":[{\"from\":0,\"to\":30,\"color\":\"#16943E\"},{\"from\":31,\"to\":70,\"color\":\"#DFBE2E\"},{\"from\":71,\"to\":100,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-C4A71009B0444B41"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   caid\n| json \"input.eventType\",\"input.host.hostname\" as eventType,hostname\n| where hostname matches \"{{hostname}}\"\n| where %\"input.match.severity\">0\n| dedup %\"input.match.uuid\"\n| replace(eventType,\"GPThreatMatchExecEvent\",\"Threat Prevention\") as eventType\n| replace(eventType,\"GPDownloadEvent\",\"Download Event\") as eventType\n| replace(eventType,\"GPFSEvent\",\"File System Event\") as eventType\n| replace(eventType,\"GPGatekeeperEvent\",\"Gatekeeper Event\") as eventType\n| replace(eventType,\"GPPreventedExecutionEvent\",\"Custom Prevention\") as eventType\n| replace(eventType,\"GPProcessEvent\",\"Process Event\") as eventType\n| replace(eventType,\"auth-mount\",\"Device Controls\") as eventType\n| replace(eventType,\"GPClickEvent\",\"Synthetic Click Event\") as eventType\n| replace(eventType,\"GPUSBEvent\",\"USB Event\") as eventType\n| count eventType"
        query_type   = "Logs"
      }

      title           = "Observed Event Types"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-EF7230839FBA0945"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   caid\nGPGatekeeperEvent\n| json \"input.match.facts[0].name\", \"input.match.event.path\" as Block_Type, Executable\n| json \"input.host.hostname\" as hostname\n| where hostname matches \"{{hostname}}\"\n| count Block_Type, Executable\n| order by _count desc\n| top 10 Block_Type, Executable by _count"
        query_type   = "Logs"
      }

      title           = "Top Gatekeeper Blocked Items"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\",\"paginationPageSize\":10},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-25D612C293CFB849"
      title                                       = "macOS Built-In Security Tools"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"text\":{\"format\":\"markdownV2\"},\"series\":{},\"title\":{\"fontSize\":30},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-7768572187238A45"
      title                                       = "Device Controls"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"text\":{\"format\":\"markdownV2\"},\"series\":{},\"title\":{\"fontSize\":30},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-87D19A9DA4785B40"
      title                                       = "Events by Severity"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"text\":{\"format\":\"markdownV2\",\"fontSize\":20},\"series\":{},\"legend\":{\"enabled\":false},\"title\":{\"fontSize\":30}}"
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

  title = "Jamf Protect - Alerts Overview"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "hostname"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "hostname"

    source_definition {
      log_query_variable_source_definition {
        field = "hostname"
        query = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  ) caid \n| json field=_raw \"input.host.hostname\" as hostname"
      }
    }
  }
}

resource "sumologic_dashboard" "jamf_protect_telemetry_overview" {
  description = "Overview of events from Telemetry stream"
  folder_id   = sumologic_folder.jamf_protect_folder.id

  variable {
    allow_multi_select = "false"
    default_value      = var.default_scope_value1
    display_name = var.scope_key1_variable_display_name
    hide_from_ui       = "false"
    include_all_option = "true"
    name = var.scope_key1_variable_display_name
    source_definition {
      csv_variable_source_definition {
        values = "${var.default_scope_value1}"
      }
    }
  }

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
        key       = "panel177E1ACEA66B0841"
        structure = "{\"height\":5,\"width\":4,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panel39C03F36B051F84C"
        structure = "{\"height\":11,\"width\":24,\"x\":0,\"y\":52}"
      }

      layout_structure {
        key       = "panel49B07E9A86E1F840"
        structure = "{\"height\":5,\"width\":4,\"x\":4,\"y\":0}"
      }

      layout_structure {
        key       = "panel79FDC3A9A66A5845"
        structure = "{\"height\":5,\"width\":4,\"x\":16,\"y\":0}"
      }

      layout_structure {
        key       = "panel86B9D15096677B46"
        structure = "{\"height\":5,\"width\":4,\"x\":8,\"y\":0}"
      }

      layout_structure {
        key       = "panelDC1B0CEC955D6947"
        structure = "{\"height\":5,\"width\":4,\"x\":20,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-3617EFEC871F3A49"
        structure = "{\"height\":7,\"width\":24,\"x\":0,\"y\":5}"
      }

      layout_structure {
        key       = "panelPANE-36181AD1A0509B40"
        structure = "{\"height\":11,\"width\":24,\"x\":0,\"y\":32}"
      }

      layout_structure {
        key       = "panelPANE-36E001B4B3D4484E"
        structure = "{\"height\":9,\"width\":12,\"x\":12,\"y\":43}"
      }

      layout_structure {
        key       = "panelPANE-51EB6BA8B652084F"
        structure = "{\"height\":9,\"width\":24,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-8699F7CAB36D7840"
        structure = "{\"height\":9,\"width\":12,\"x\":0,\"y\":43}"
      }

      layout_structure {
        key       = "panelPANE-9EC66EB3BC603948"
        structure = "{\"height\":5,\"width\":4,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-E661E99185B8294C"
        structure = "{\"height\":11,\"width\":24,\"x\":0,\"y\":21}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel177E1ACEA66B0841"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   !caid\n| json field=_raw \"subject.audit_user_name\",\"texts\",\"return.error\",\"host_info.host_name\" as Username, texts, return_error, Hostname\n| parse regex field=texts \"mechanism\\s(?<auth_mech>\\w+)\\:(?<auth_mech_verb>\\w+)\\,(?<auth_mech_rights>\\w+)\"\n| where %\"host_info.host_name\" matches \"{{hostname}}\"\n| where %\"header.event_name\" = \"AUE_ssauthmech\"\n| where %\"subject.audit_user_name\" != \"-1\"\n| where auth_mech_rights = \"privileged\"\n| where auth_mech_verb = \"authenticate\"\n| if(return_error = 0,1,0) as success\n| if(return_error != 0,1,0) as failure\n| values(process_exec) as ProcessExec, sum(failure) as failure, sum(success) as success, values(return_error) as return_error, values(%\"return.description\") AS ReturnDesc, values(texts) as Texts, values(Hostname) as Hostname, count by Username\n| count by Hostname, Username, success, failure\n| fields Hostname, Username, success, failure\n| sum(failure) as Total_Failure"
        query_type   = "Logs"
      }

      title           = "Admin Prompts"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel39C03F36B051F84C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   !caid\n| json field=_raw \"host_info.host_name\" as hostname\n| where hostname matches \"{{hostname}}\"\n| where !(%\"socket_inet.ip_address\"=\"0.0.0.0\")\n| where !(%\"socket_inet.ip_address\"=\"127.0.0.1\")\n| where !(%\"socket_inet.ip_address\"=\"::\")\n| where !isnull(%\"socket_inet.ip_address\")\n| %\"socket_inet.ip_address\" as dest_ip\n| fields -%\"socket_inet.ip_address\"\n| values(%\"host_info.host_name\") as hostname, values(dest_ip) as dest_ip, count by %\"subject.process_name\",%\"exec_chain_child.parent_path\"\n| fields _count, hostname, %\"subject.process_name\",%\"exec_chain_child.parent_path\"\n| sort _count desc"
        query_type   = "Logs"
      }

      title           = "Network Traffic by Process"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel49B07E9A86E1F840"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   !caid\n| json field=_raw \"subject.audit_user_name\",\"texts\",\"return.error\",\"host_info.host_name\" as Username, texts, return_error, Hostname\n| where %\"host_info.host_name\" matches \"{{hostname}}\"\n| where %\"subject.process_name\" = \"/System/Library/Frameworks/Security.framework/Versions/A/MachServices/authorizationhost.bundle/Contents/MacOS/authorizationhost\" \n| where %\"header.event_name\" = \"AUE_auth_user\" or %\"header.event_name\" = \"AUE_lw_login\"\n| if(return_error = 0,1,0) as success\n| if(return_error != 0,1,0) as failure\n| values(process_exec) as ProcessExec, sum(failure) as failure, sum(success) as success, values(return_error) as return_error, values(%\"return.description\") AS ReturnDesc, values(texts) as Texts, values(Hostname) as Hostname, count by Username\n| count by Hostname, Username, success, failure\n| fields Hostname, Username, success, failure\n| sum(failure) as Total_Failure "
        query_type   = "Logs"
      }

      title           = "Login Window"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\",\"noDataMessage\":\"0\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel79FDC3A9A66A5845"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   !caid\n| json field=_raw \"subject.audit_user_name\",\"texts\",\"return.error\",\"host_info.host_name\" as Username, texts, return_error, Hostname\n| where %\"host_info.host_name\" matches \"{{hostname}}\"\n| where %\"header.event_name\" = \"AUE_auth_user\"\n| where %\"subject.process_name\" = \"/usr/bin/sudo\"\n| if(return_error = 0,1,0) as success\n| if(return_error != 0,1,0) as failure\n| values(process_exec) as ProcessExec, sum(failure) as failure, sum(success) as success, values(return_error) as return_error, values(%\"return.description\") AS ReturnDesc, values(texts) as Texts, values(Hostname) as Hostname, count by Username\n| count by Hostname, Username, success, failure\n| fields Hostname, Username, success, failure\n| sum(failure) as Total_Failure "
        query_type   = "Logs"
      }

      title           = "Sudo"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel86B9D15096677B46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   !caid\n| json field=_raw \"subject.audit_user_name\",\"texts\",\"return.error\",\"host_info.host_name\" as Username, texts, return_error, Hostname\n| where %\"host_info.host_name\" matches \"{{hostname}}\"\n| where %\"subject.process_name\" = \"/System/Library/CoreServices/loginwindow.app/Contents/MacOS/loginwindow\" \n| where %\"header.event_id\" = 45023\n| if(return_error = 0,1,0) as success\n| if(return_error != 0,1,0) as failure\n| values(process_exec) as ProcessExec, sum(failure) as failure, sum(success) as success, values(return_error) as return_error, values(%\"return.description\") AS ReturnDesc, values(texts) as Texts, values(Hostname) as Hostname, count by Username\n| count by Hostname, Username, success, failure\n| fields Hostname, Username, success, failure\n| sum(failure) as Total_Failure "
        query_type   = "Logs"
      }

      title           = "Lock Screen"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelDC1B0CEC955D6947"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   !caid\n| json field=_raw \"subject.audit_user_name\",\"texts\",\"return.error\",\"host_info.host_name\" as Username, texts, return_error, Hostname\n| where %\"host_info.host_name\" matches \"{{hostname}}\"\n| where %\"header.event_name\" = \"AUE_openssh\"\n| if(return_error = 0,1,0) as success\n| if(return_error != 0,1,0) as failure\n| values(process_exec) as ProcessExec, sum(failure) as failure, sum(success) as success, values(return_error) as return_error, values(%\"return.description\") AS ReturnDesc, values(texts) as Texts, values(Hostname) as Hostname, count by Username\n| count by Hostname, Username, success, failure\n| fields Hostname, Username, success, failure\n| sum(failure) as Total_Failure "
        query_type   = "Logs"
      }

      title           = "SSH"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-3617EFEC871F3A49"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   !caid\n| json \"host_info.host_name\" as Hostname\n| where %\"host_info.host_name\" matches \"{{hostname}}\"\n| count Hostname\n| sort _count desc"
        query_type   = "Logs"
      }

      title           = "Most Active Endpoints "
      visual_settings = "{\"series\":{},\"legend\":{\"enabled\":false},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"overrides\":[],\"color\":{\"family\":\"Categorical Default\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-36181AD1A0509B40"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   !caid\n| timeslice 1d\n| json field=_raw \"subject.process_name\",\"exec_chain_child.parent_path\",\"exec_chain.thread_uuid\",\"host_info.host_name\" as Process, ParentProcess, ThreadUuid, Hostname\n| where Hostname matches \"{{hostname}}\"\n| count Hostname, Process, ParentProcess\n| sort by _count asc \n| limit 50"
        query_type   = "Logs"
      }

      title           = "Rare Process Executions (All Executions)"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":10},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-36E001B4B3D4484E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   !caid\n| json \"host_info.host_name\" as Hostname\n| where Hostname matches \"{{hostname}}\"\n| where !(%\"socket_inet.ip_address\"=\"0.0.0.0\")\n| where !(%\"socket_inet.ip_address\"=\"127.0.0.1\")\n| where !(%\"socket_inet.ip_address\"=\"::\")\n| where !isnull(%\"socket_inet.ip_address\")\n| %\"socket_inet.ip_address\" as dest_ip\n| fields -%\"socket_inet.ip_address\"\n| geoip dest_ip\n| count by country_name \n| where !isnull(country_name)\n| sort by _count desc"
        query_type   = "Logs"
      }

      title           = "Network Traffic by Country"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-51EB6BA8B652084F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   !caid\n| formatDate(_receiptTime, \"yyyy-MM-dd HH:mm:ss\", \"etc/utc\") as Date\n| json \"host_info.host_name\", \"subject.audit_user_name\", \"exec_env.env.SUDO_COMMAND\" as Hostname, Elevated_User, Compiled_Arguments\n| where Hostname matches \"{{hostname}}\"\n| where %\"identity.signer_id\" = \"com.apple.sudo\"\n| where %\"subject.effective_user_name\" = \"root\" \n| where %\"subject.audit_user_name\" != \"\"\n| count Date, Hostname, Elevated_User, Compiled_Arguments\n| order by Date\n| fields -_count"
        query_type   = "Logs"
      }

      title           = "All Successful Sudo Commands"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-8699F7CAB36D7840"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   !caid\n| json \"host_info.host_name\" as Hostname\n| where Hostname matches \"{{hostname}}\"\n| where !(%\"socket_inet.ip_address\"=\"0.0.0.0\")\n| where !(%\"socket_inet.ip_address\"=\"127.0.0.1\")\n| where !(%\"socket_inet.ip_address\"=\"::\")\n| where !isnull(%\"socket_inet.ip_address\")\n| %\"socket_inet.ip_address\" as dest_ip\n| fields -%\"socket_inet.ip_address\"\n| geoip dest_ip\n| count by latitude, longitude\n| where !isnull(latitude)\n| where !isnull(longitude)"
        query_type   = "Logs"
      }

      title           = "Network Traffic by Destination"
      visual_settings = "{\"general\":{\"mode\":\"map\",\"type\":\"map\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-E661E99185B8294C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   !caid\n| formatDate(_messagetime, \"yyyy-MM-dd HH:mm:ss\", \"etc/utc\") as Date\n| json \"header.event_name\", \"return.description\", \"host_info.host_name\", \"subject.terminal_id.ip_address\", \"subject.effective_user_name\", \"exec_args.args_compiled\" as EventName, Return, Hostname, IPAddress, User, Args\n| where Hostname matches \"{{hostname}}\"\n| where IPAddress != \"0.0.0.0\"\n| where EventName = \"AUE_SESSION_START\" or EventName = \"AUE_EXECVE\" or EventName = \"AUE_openssh\"\n| count Date, EventName, Return, Hostname, IPAddress, User, Args\n| order by Date\n| fields -_count"
        query_type   = "Logs"
      }

      title           = "Remotely Controlled Commands"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-9EC66EB3BC603948"
      title                                       = "Authentication Events"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"title\":{\"fontSize\":15},\"text\":{\"format\":\"markdownV2\",\"fontSize\":20},\"series\":{},\"legend\":{\"enabled\":false}}"
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

  title = "Jamf Protect - Telemetry Overview"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "hostname"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "hostname"

    source_definition {
      log_query_variable_source_definition {
        field = "hostname"
        query = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  ) !caid \n| json field=_raw \"host_info.host_name\" as hostname"
      }
    }
  }
}

resource "sumologic_dashboard" "jamf_security_cloud_threat_stream" {
  description = "Overview of events from network threat stream"
  folder_id   = sumologic_folder.jamf_security_cloud_folder.id

  variable {
    allow_multi_select = "false"
    default_value      = var.default_scope_value1
    display_name = var.scope_key1_variable_display_name
    hide_from_ui       = "false"
    include_all_option = "true"
    name = var.scope_key1_variable_display_name
    source_definition {
      csv_variable_source_definition {
        values = "${var.default_scope_value1}"
      }
    }
  }

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
        key       = "panelE1A4FDD79C148846"
        structure = "{\"height\":10,\"width\":24,\"x\":0,\"y\":21}"
      }

      layout_structure {
        key       = "panelPANE-0B8945C98E970B43"
        structure = "{\"height\":8,\"width\":7,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-4F9B25FE82E4C944"
        structure = "{\"height\":9,\"width\":12,\"x\":12,\"y\":31}"
      }

      layout_structure {
        key       = "panelPANE-71CF22358089C94B"
        structure = "{\"height\":7,\"width\":12,\"x\":0,\"y\":14}"
      }

      layout_structure {
        key       = "panelPANE-905B4B8D9E3F4B4A"
        structure = "{\"height\":9,\"width\":12,\"x\":0,\"y\":31}"
      }

      layout_structure {
        key       = "panelPANE-CB7E5B269AA5384D"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":8}"
      }

      layout_structure {
        key       = "panelPANE-CE1CA817BEBA7B4F"
        structure = "{\"height\":8,\"width\":17,\"x\":7,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-DC9BCAF28040D84F"
        structure = "{\"height\":7,\"width\":12,\"x\":12,\"y\":14}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelE1A4FDD79C148846"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   !\"Network Traffic Stream\")\n| dedup event.timestamp\n| json field=_raw \"event.metadata.product\", \"event.eventType.description\", \"event.device.userDeviceName\" as product, eventType, Hostname\n| where Hostname matches \"{{Hostname}}\"\n| where product = \"Threat Events Stream\" AND eventType contains \"Risky Host\"\n| fields Hostname, eventType, %\"event.destination.name\", %\"event.destination.ip\"\n| count Hostname\n| sort _count desc"
        query_type   = "Logs"
      }

      title           = "Endpoint Highest Visit - Risky Hosts"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"bar\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{},\"legend\":{\"enabled\":false},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-0B8945C98E970B43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   !\"Network Traffic Stream\"\n| json field=_raw \"event.action\", \"event.metadata.product\",\"event.device.userDeviceName\" as action, product, hostname\n| where hostname matches \"{{Hostname}}\"\n| where product = \"Threat Events Stream\" AND action = \"Blocked\"\n| dedup event.timestamp\n| count by action\n\n"
        query_type   = "Logs"
      }

      title           = "Threats Blocked by NTP"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"label\":\"Blocks\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":true,\"rounding\":2,\"valueFontSize\":50,\"labelFontSize\":14,\"thresholds\":[{\"from\":0,\"to\":30,\"color\":\"#16943E\"},{\"from\":31,\"to\":70,\"color\":\"#DFBE2E\"},{\"from\":71,\"to\":100,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-4F9B25FE82E4C944"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   !\"Network Traffic Stream\"\n| dedup event.timestamp\n| json field=_raw \"event.action\", \"event.metadata.product\",\"event.destination.ip\",\"event.device.userDeviceName\" as action, product, IP_Address, Hostname\n| where Hostname matches \"{{Hostname}}\"\n| where product = \"Threat Events Stream\" and !isBlank(IP_Address)\n| count IP_Address\n| order by _count desc\n| top 10 IP_Address by _count"
        query_type   = "Logs"
      }

      title           = "Top 10 Blocked IPs"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-71CF22358089C94B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   !\"Network Traffic Stream\"\n| timeslice 1d\n| dedup event.timestamp\n| json field=_raw \"event.metadata.product\", \"event.eventType.description\", \"event.device.userDeviceName\" as product, eventType, Hostname\n| where Hostname matches \"{{Hostname}}\"\n| where product = \"Threat Events Stream\" AND !isBlank(eventType)\n| count _timeslice, eventType\n| transpose row _timeslice column eventType\n\n"
        query_type   = "Logs"
      }

      title           = "Network Events Detected (Count by Type)"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"area\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"fillOpacity\":0.25,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-905B4B8D9E3F4B4A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   !\"Network Traffic Stream\"\n| dedup event.timestamp\n| json field=_raw \"event.action\", \"event.metadata.product\", \"event.destination.name\", \"event.device.userDeviceName\" as action, product, Domain, Hostname\n| where Hostname matches \"{{Hostname}}\"\n| where product = \"Threat Events Stream\" and !isBlank(Domain)\n| count Domain\n| order by _count desc\n| top 10 Domain by _count"
        query_type   = "Logs"
      }

      title           = "Top 10 Blocked Domains"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-CB7E5B269AA5384D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   !\"Network Traffic Stream\"\n| timeslice 1d\n| dedup event.timestamp\n| json field=_raw \"event.action\",\"event.metadata.product\",\"event.severity\",\"event.device.userDeviceName\" as action, product, severity, Hostname\n| where Hostname matches \"{{Hostname}}\"\n| where product = \"Threat Events Stream\" AND action = \"Blocked\"\n| replace(severity,\"10\",\"Very High\") as severity\n| replace(severity,\"8\",\"High\") as severity\n| replace(severity,\"6\",\"Medium\") as severity\n| replace(severity,\"4\",\"Low\") as severity\n| replace(severity,\"2\",\"Very Low\") as severity\n| count _timeslice, severity\n| transpose row _timeslice column severity"
        query_type   = "Logs"
      }

      title           = "Network Events Detected (Count  by Severity)"
      visual_settings = "{\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{},\"general\":{\"type\":\"area\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"fillOpacity\":0.25,\"mode\":\"timeSeries\"},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"showAsTable\":true},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-CE1CA817BEBA7B4F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   !\"Network Traffic Stream\"\n| dedup event.timestamp\n| json field=_raw \"event.action\", \"event.metadata.product\",\"event.device.userDeviceName\" as action, product, Hostname\n| where Hostname matches \"{{Hostname}}\"\n| where product = \"Threat Events Stream\" AND !isBlank(Hostname)\n| count Hostname\n| sort _count desc\n"
        query_type   = "Logs"
      }

      title           = "Most Active Endpoints"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":10},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-DC9BCAF28040D84F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   !\"Network Traffic Stream\"\n| timeslice 1d\n| dedup event.timestamp\n| json field=_raw \"event.metadata.product\", \"event.eventType.description\", \"event.device.userDeviceName\" as product, eventType, Hostname\n| where Hostname matches \"{{Hostname}}\"\n| where product = \"Threat Events Stream\" AND !isBlank(eventType)\n| count eventType\n"
        query_type   = "Logs"
      }

      title           = "Event Types"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"legend\":{\"enabled\":false}}"
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

  title = "Jamf Security Cloud - Threat Stream"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "Hostname"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "Hostname"

    source_definition {
      log_query_variable_source_definition {
        field = "Hostname"
        query = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   !\"Network Traffic Stream\"\n| json field=_raw \"event.device.userDeviceName\" as Hostname"
      }
    }
  }
}
