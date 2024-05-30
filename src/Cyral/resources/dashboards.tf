resource "sumologic_dashboard" "cyral_application_activity_details" {
  description = "Dashboard that provides specific information regarding an application."
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
        key       = "panel19FAB4BB8ABDEA4A"
        structure = "{\"height\":4,\"width\":6,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panel308348DD82ED894B"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":22}"
      }

      layout_structure {
        key       = "panel33893985BA142944"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":4}"
      }

      layout_structure {
        key       = "panel3C7601F9A363594B"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":16}"
      }

      layout_structure {
        key       = "panel4D3192D780F64A4E"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":22}"
      }

      layout_structure {
        key       = "panel5EEA3E3EB7F3BB45"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":10}"
      }

      layout_structure {
        key       = "panel600082A9BDE60B41"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":28}"
      }

      layout_structure {
        key       = "panel72DA3F04B63BB84A"
        structure = "{\"height\":4,\"width\":6,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panel8E37E9109A75DB46"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":10}"
      }

      layout_structure {
        key       = "panelB0776BCC9C5D094E"
        structure = "{\"height\":4,\"width\":6,\"x\":6,\"y\":0}"
      }

      layout_structure {
        key       = "panelC10E1A50AA647843"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":16}"
      }

      layout_structure {
        key       = "panelC8AF40D289B5394A"
        structure = "{\"height\":4,\"width\":6,\"x\":18,\"y\":0}"
      }

      layout_structure {
        key       = "panelE4DE1B54B8788945"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":4}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel19FAB4BB8ABDEA4A"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"client.applicationName\" nodrop\n| where !isNull(%\"identity.group\")\n| json \"request.datasetsAccessed[*].accessType\" as accessType\n| where accessType CONTAINS \"read\" and %\"client.applicationName\" matches \"{{applicationName}}\"\n| count"
        query_type   = "Logs"
      }

      title           = "Total Reads"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"Reads\",\"sparkline\":{\"show\":true,\"color\":\"\"},\"gauge\":{\"show\":false},\"valueFontSize\":24,\"labelFontSize\":14,\"useBackgroundColor\":true}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel308348DD82ED894B"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"request.datasetsAccessed[*].accessType\" as accessType nodrop\n| json \"request.datasetsAccessed[*].dataset\" as dataset nodrop\n| json \"client.applicationName\",\"request.statementType\",\"response.records\",\"identity.endUser\",\"repo.name\" nodrop\n| where %\"client.applicationName\" matches \"{{applicationName}}\" and %\"request.statementType\" IN (\"DELETE\",\"UPDATE\",\"INSERT\")\n| sum(%\"response.records\") as TotalRecords, count(accessType) as Queries by %\"identity.endUser\", %\"repo.name\", dataset "
        query_type   = "Logs"
      }

      title           = "Modifications"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel33893985BA142944"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"identity.endUser\",\"client.applicationName\",\"response.records\",\"request.statementType\" nodrop\n| where !isNull(%\"identity.group\") AND %\"identity.endUser\" matches \"*\" and %\"client.applicationName\" matches \"{{applicationName}}\"\n| sum(%\"response.records\") by %\"request.statementType\""
        query_type   = "Logs"
      }

      title           = "Statement Type Breakdown by Sum of Records"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{\"UPDATE\":{\"visible\":true},\"INSERT\":{\"visible\":true},\"DELETE\":{\"visible\":true},\"SELECT\":{\"visible\":true},\"CREATE\":{\"visible\":true}},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel3C7601F9A363594B"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"identity.endUser\",\"client.applicationName\",\"response.records\",\"client.host\" nodrop\n| where %\"identity.group\" matches \"*\" AND %\"identity.endUser\" matches \"*\" and %\"client.applicationName\" matches \"{{applicationName}}\"\n| sum(%\"response.records\") as TotalRecords by %\"client.host\"\n| sort by TotalRecords desc\n| limit {{topKLimit}}"
        query_type   = "Logs"
      }

      title           = "Top {{topKLimit}} Hosts by Sum Records"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"bar\"},\"series\":{},\"overrides\":[],\"axes\":{\"axisX\":{\"title\":\"Client Host\",\"hideLabels\":true},\"axisY\":{\"title\":\"Total Records\"}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel4D3192D780F64A4E"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"request.datasetsAccessed[*].accessType\" as accessType nodrop\n| json \"request.datasetsAccessed[*].dataset\" as dataset nodrop\n| json \"client.applicationName\",\"response.records\",\"identity.endUser\",\"repo.name\" nodrop\n| where %\"client.applicationName\" matches \"{{applicationName}}\" and accessType=\"[\\\"read\\\"]\"\n| sum(%\"response.records\") as TotalRecords, count(accessType) as Queries by %\"identity.endUser\", %\"repo.name\", dataset "
        query_type   = "Logs"
      }

      title           = "Data Reads Breakdown"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel5EEA3E3EB7F3BB45"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"identity.endUser\",\"client.applicationName\",\"response.records\" nodrop\n| where %\"identity.group\" matches \"*\" AND %\"identity.endUser\" matches \"*\" and %\"client.applicationName\" matches \"{{applicationName}}\"\n| sum(%\"response.records\") as TotalRecords by %\"identity.endUser\"\n| sort by TotalRecords desc\n| limit {{topKLimit}}"
        query_type   = "Logs"
      }

      title           = "Top {{topKLimit}} End Users By Sum Records"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"bar\"},\"series\":{},\"overrides\":[],\"axes\":{\"axisX\":{\"title\":\"User\",\"hideLabels\":true},\"axisY\":{\"title\":\"Total Records\",\"hideLabels\":false}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel600082A9BDE60B41"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"client.applicationName\",\"activityTime\",\"response.records\",\"response.bytes\",\"repo.name\",\"identity.repoUser\",\"client.connectionId\" nodrop\n| where %\"identity.group\" matches \"*\" and %\"client.applicationName\" matches \"{{applicationName}}\"|first(%\"activityTime\") as SessionStart, last(%\"activityTime\") as SessionEnd, sum(%\"response.records\") as Records, sum(%\"response.bytes\") as Bytes by %\"repo.name\", %\"identity.repoUser\", %\"identity.group\", %\"client.connectionId\"\n| sort by SessionEnd desc\n| limit {{topKLimit}}"
        query_type   = "Logs"
      }

      title           = "{{topKLimit}} Most Recent Sessions"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel72DA3F04B63BB84A"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"response.message\",\"client.applicationName\",\"response.records\" nodrop\n| where !isNull(%\"identity.group\") and !isNull(%\"response.message\") and %\"client.applicationName\" matches \"{{applicationName}}\"\n| avg(%\"response.records\")"
        query_type   = "Logs"
      }

      title           = "Avg Records Read"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Average\",\"label\":\"Records\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":0,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8E37E9109A75DB46"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"identity.endUser\",\"client.applicationName\",\"response.records\",\"repo.name\" nodrop\n| where %\"identity.group\" matches \"*\" AND %\"identity.endUser\" matches \"*\" and %\"client.applicationName\" matches \"{{applicationName}}\"\n| sum(%\"response.records\") as TotalRecords by %\"repo.name\"\n| sort by TotalRecords desc\n| limit {{topKLimit}}"
        query_type   = "Logs"
      }

      title           = "Top {{topKLimit}} Repos By Sum Records"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"bar\"},\"series\":{},\"axes\":{\"axisX\":{\"title\":\"Repo Name\",\"hideLabels\":true},\"axisY\":{\"title\":\"Total Records\"}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB0776BCC9C5D094E"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"response.message\",\"client.applicationName\",\"response.executionTimeNanos\" nodrop\n| where !isNull(%\"identity.group\") and !isNull(%\"response.message\") and %\"client.applicationName\" matches \"{{applicationName}}\"\n| %\"response.executionTimeNanos\" / 1000000 as executionTimeInMS\n| avg(executionTimeInMS)"
        query_type   = "Logs"
      }

      title           = "Avg Execution Time"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Average\",\"label\":\"ms\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelC10E1A50AA647843"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"policyViolations[*].policyName\" as policyName nodrop\n| json \"policyViolations[*].severity\" as policySeverity nodrop\n| json \"policyViolations[*].accessType\" as accessType nodrop\n| json \"policyViolated\" as policyViolated nodrop\n| json \"client.applicationName\" as applicationName nodrop\n| where policyViolated=\"true\" and applicationName matches \"{{applicationName}}\"\n| count as Violations by policyName,policySeverity,accessType\n| sort by Violations desc\n| limit {{topKLimit}}"
        query_type   = "Logs"
      }

      title           = "Top {{topKLimit}} Policy Violations"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelC8AF40D289B5394A"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"response.message\",\"client.applicationName\",\"response.bytes\" nodrop\n| where !isNull(%\"identity.group\") and !isNull(%\"response.message\") and %\"client.applicationName\" matches \"{{applicationName}}\"\n| avg(%\"response.bytes\")"
        query_type   = "Logs"
      }

      title           = "Avg Bytes Read"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"Bytes\",\"rounding\":0}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelE4DE1B54B8788945"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"identity.endUser\",\"client.applicationName\",\"response.records\",\"request.statementType\" nodrop\n| where !isNull(%\"identity.group\") AND %\"identity.endUser\" matches \"*\" and %\"client.applicationName\" matches \"{{applicationName}}\"\n| timeslice 15m\n| sum(%\"response.records\") by _timeslice, %\"request.statementType\"\n| transpose row _timeslice column %\"request.statementType\""
        query_type   = "Logs"
      }

      title           = "User Statement Type Trend by Sum of Records"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\"},\"series\":{\"A_DELETE\":{\"visible\":true}},\"overrides\":[]}"
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

  title = "Cyral - Application Activity Details"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "applicationName"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "applicationName"

    source_definition {
      log_query_variable_source_definition {
        field = "applicationName"
        query = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )|json \"client.applicationName\" as applicationName|count by applicationName"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "5"
    display_name       = "topKLimit"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "topKLimit"

    source_definition {
      csv_variable_source_definition {
        values = "5,10,25,50,100"
      }
    }
  }
}

resource "sumologic_dashboard" "cyral_data_monitoring_activity" {
  description = "Dashboard that provides a view of how users and groups are accessing data and the types of queries they are executing against the data."
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
        key       = "panel00FE41DCA5C91B44"
        structure = "{\"height\":4,\"width\":4,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panel08DF46AAA4A2EB4E"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":22}"
      }

      layout_structure {
        key       = "panel3DE20BE5A4FF984B"
        structure = "{\"height\":4,\"width\":4,\"x\":4,\"y\":0}"
      }

      layout_structure {
        key       = "panel40B3723EA7A51847"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":22}"
      }

      layout_structure {
        key       = "panel41A06B049ADFA84C"
        structure = "{\"height\":4,\"width\":4,\"x\":20,\"y\":0}"
      }

      layout_structure {
        key       = "panel77590EADADF91A45"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":28}"
      }

      layout_structure {
        key       = "panel7FD1F0A59123D84E"
        structure = "{\"height\":4,\"width\":4,\"x\":8,\"y\":0}"
      }

      layout_structure {
        key       = "panel8CFE3C7793C7E848"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":16}"
      }

      layout_structure {
        key       = "panelB01EF3A89273094A"
        structure = "{\"height\":4,\"width\":4,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panelCDE09E0F9057AB4E"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":16}"
      }

      layout_structure {
        key       = "panelEBA3D969B2D6EA47"
        structure = "{\"height\":4,\"width\":4,\"x\":16,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-9B92CFD19042A943"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":4}"
      }

      layout_structure {
        key       = "panelPANE-BCDAF36593E8E94D"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":10}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel00FE41DCA5C91B44"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"request.statementType\",\"activityTypes\",\"identity.endUser\" nodrop\n| where %\"identity.group\" matches \"{{GroupName}}\" AND %\"request.statementType\" matches \"{{StatementType}}\" AND %\"activityTypes\" CONTAINS \"query\"\n| count_distinct(%\"identity.endUser\")"
        query_type   = "Logs"
      }

      title           = "Number of Users"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"Users\",\"noDataString\":\"0\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel08DF46AAA4A2EB4E"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"request.statementType\",\"identity.endUser\" nodrop\n| where %\"identity.group\" matches \"{{GroupName}}\" AND %\"request.statementType\" matches \"{{StatementType}}\"\n| count by %\"identity.endUser\", %\"request.statementType\"\n| transpose row %\"identity.endUser\" column %\"request.statementType\""
        query_type   = "Logs"
      }

      title           = "Queries By User - Aggregate"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"column\"},\"series\":{},\"overrides\":[],\"axes\":{\"axisX\":{\"title\":\"User\"},\"axisY\":{\"title\":\"\"}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel3DE20BE5A4FF984B"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"request.statementType\",\"activityTime\",\"identity.endUser\",\"identity.repoUser\" nodrop\n| where %\"identity.group\" matches \"{{GroupName}}\" AND %\"request.statementType\" matches \"{{StatementType}}\"\n| first(%\"activityTime\") by %\"identity.endUser\", %\"identity.group\", %\"identity.repoUser\"\n| now()-30d as expireTime|parseDate(_first, \"yyyy-MM-dd HH:mm:ss\") as parsedDate\n| where expireTime > parsedDate\n| count"
        query_type   = "Logs"
      }

      title           = "Inactive Users"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"Users\",\"noDataString\":\"0\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel40B3723EA7A51847"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"request.statementType\",\"identity.endUser\" nodrop\n| where %\"identity.group\" matches \"{{GroupName}}\" AND %\"request.statementType\" matches \"{{StatementType}}\"\n| timeslice 15m\n| count by _timeslice, %\"identity.endUser\"\n| transpose row _timeslice column %\"identity.endUser\""
        query_type   = "Logs"
      }

      title           = "Query Trend By User"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel41A06B049ADFA84C"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"request.statementType\",\"response.message\",\"response.bytes\" nodrop\n| where %\"identity.group\" matches \"{{GroupName}}\" AND %\"request.statementType\" matches \"{{StatementType}}\" and !isNull(%\"response.message\")\n| avg(%\"response.bytes\")"
        query_type   = "Logs"
      }

      title           = "Avg Bytes Read"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"Bytes\",\"noDataString\":\"0\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel77590EADADF91A45"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"request.statementType\",\"activityTime\",\"identity.endUser\",\"identity.repoUser\" nodrop\n| where %\"identity.group\" matches \"{{GroupName}}\" AND %\"request.statementType\" matches \"{{StatementType}}\"\n| first(%\"activityTime\") by %\"identity.endUser\", %\"identity.group\", %\"identity.repoUser\""
        query_type   = "Logs"
      }

      title           = "Recent Activity By User"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel7FD1F0A59123D84E"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"request.statementType\" nodrop\n| where %\"identity.group\" matches \"{{GroupName}}\" AND %\"request.statementType\" matches \"{{StatementType}}\"\n| json \"request.datasetsAccessed[*].accessType\" as accessType nodrop\n| where accessType CONTAINS \"read\"\n| count"
        query_type   = "Logs"
      }

      title           = "Total Reads"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"Reads\",\"noDataString\":\"0\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8CFE3C7793C7E848"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"activityTypes\",\"identity.group\",\"request.statementType\" nodrop\n| where %\"activityTypes\" contains \"query\" and %\"identity.group\" matches \"{{GroupName}}\" AND %\"request.statementType\" matches \"{{StatementType}}\"|if(isBlank(%\"identity.group\"), \"blank\", %\"identity.group\") as myField\n| where myField != \"blank\"\n| count by %\"identity.group\", %\"request.statementType\"\n| transpose row %\"identity.group\" column %\"request.statementType\" as *"
        query_type   = "Logs"
      }

      title           = "Requests by SSO Group"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"column\",\"displayType\":\"stacked\"},\"series\":{},\"overrides\":[],\"axes\":{\"axisX\":{\"title\":\"Group\"},\"axisY\":{\"title\":\"\"}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB01EF3A89273094A"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"request.statementType\",\"response.message\",\"response.executionTimeNanos\" nodrop\n| where %\"identity.group\" matches \"{{GroupName}}\" AND %\"request.statementType\" matches \"{{StatementType}}\" and !isNull(%\"response.message\")\n| %\"response.executionTimeNanos\" / 1000000 as executionTimeInMS\n| avg(executionTimeInMS)"
        query_type   = "Logs"
      }

      title           = "Avg Execution Time"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"ms\",\"noDataString\":\"0\",\"rounding\":0}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelCDE09E0F9057AB4E"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"activityTypes\",\"identity.group\",\"request.statementType\" nodrop\n| where %\"activityTypes\" contains \"query\" AND %\"identity.group\" matches \"{{GroupName}}\" AND %\"request.statementType\" matches \"{{StatementType}}\"\n| timeslice 15m\n| count by _timeslice, %\"identity.group\"\n| transpose row _timeslice column %\"identity.group\""
        query_type   = "Logs"
      }

      title           = "Data Activity by SSO Group"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelEBA3D969B2D6EA47"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"request.statementType\",\"response.message\",\"response.records\" nodrop\n| where %\"identity.group\" matches \"{{GroupName}}\" AND %\"request.statementType\" matches \"{{StatementType}}\" and !isNull(%\"response.message\")\n| avg(%\"response.records\")"
        query_type   = "Logs"
      }

      title           = "Avg Records Read"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"Records\",\"noDataString\":\"0\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-9B92CFD19042A943"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"request.fieldsAccessed[*].label\" as fieldLabel nodrop\n| json \"identity.group\" as SSOGroup nodrop\n| json \"request.statementType\" nodrop\n| where SSOGroup matches \"{{GroupName}}\" AND %\"request.statementType\" matches \"{{StatementType}}\"\n| count by fieldLabel, SSOGroup"
        query_type   = "Logs"
      }

      title           = "Anomalous Read Access"
      visual_settings = "{\"general\":{\"mode\":\"honeyComb\",\"type\":\"honeyComb\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"honeyComb\":{\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#98ECA9\"},{\"from\":null,\"to\":null,\"color\":\"#F2DA73\"},{\"from\":null,\"to\":null,\"color\":\"#FFB5B5\"}],\"shape\":\"hexagon\",\"groupBy\":[],\"aggregationType\":\"count\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-BCDAF36593E8E94D"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )\n| json \"request.fieldsAccessed[*].label\" as fieldLabel nodrop\n| json \"identity.group\",\"request.statementType\" nodrop\n| where %\"identity.group\" matches \"{{GroupName}}\" AND %\"request.statementType\" matches \"{{StatementType}}\"\n| count by %\"identity.group\", %\"request.statementType\""
        query_type   = "Logs"
      }

      title           = "Groups By Statement Category"
      visual_settings = "{\"general\":{\"mode\":\"honeyComb\",\"type\":\"honeyComb\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"honeyComb\":{\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#98ECA9\"},{\"from\":null,\"to\":null,\"color\":\"#F2DA73\"},{\"from\":null,\"to\":null,\"color\":\"#FFB5B5\"}],\"shape\":\"hexagon\",\"groupBy\":[],\"aggregationType\":\"avg\"},\"series\":{},\"legend\":{\"enabled\":false}}"
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

  title = "Cyral - Data Monitoring Activity"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "GroupName"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "GroupName"

    source_definition {
      log_query_variable_source_definition {
        field = "identityGroup"
        query = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )|json \"identity.group\" as identityGroup|count by identityGroup"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "StatementType"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "StatementType"

    source_definition {
      log_query_variable_source_definition {
        field = "statementType"
        query = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )\n|json \"request.statementType\" as statementType|count by statementType"
      }
    }
  }
}

resource "sumologic_dashboard" "cyral_policy_summary" {
  description = "Dashboard that provides high level information regarding policy violations and queries that do not have policies applied."
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
        key       = "panel01F1D844AF5A4A4C"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":10}"
      }

      layout_structure {
        key       = "panel241B4531AA66484C"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":4}"
      }

      layout_structure {
        key       = "panel26FADA66828C4A4C"
        structure = "{\"height\":4,\"width\":4,\"x\":10,\"y\":0}"
      }

      layout_structure {
        key       = "panel284E1754A0316A43"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":16}"
      }

      layout_structure {
        key       = "panel2D533E1680B0184F"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":10}"
      }

      layout_structure {
        key       = "panel399254B98CAB1945"
        structure = "{\"height\":4,\"width\":5,\"x\":5,\"y\":0}"
      }

      layout_structure {
        key       = "panel3E7CE173B07CF84B"
        structure = "{\"height\":4,\"width\":5,\"x\":19,\"y\":0}"
      }

      layout_structure {
        key       = "panel4697E69A9256484D"
        structure = "{\"height\":4,\"width\":5,\"x\":14,\"y\":0}"
      }

      layout_structure {
        key       = "panel953EA468AC5AC84A"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":22}"
      }

      layout_structure {
        key       = "panel9FBED8429A57DB4D"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":4}"
      }

      layout_structure {
        key       = "panelFE36F0048F90EB43"
        structure = "{\"height\":4,\"width\":5,\"x\":0,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel01F1D844AF5A4A4C"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"policyViolated\",\"sidecar.name\",\"repo.name\",\"activityTime\" nodrop\n| json \"policyViolations[*].policyName\" as policyName nodrop\n| where %\"policyViolated\" matches \"*\" and policyName matches \"*\" and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\"\n| first(%\"activityTime\") by policyName| now()-30d as expireTime|parseDate(_first, \"yyyy-MM-dd HH:mm:ss\") as parsedDate\n| where expireTime > parsedDate|count as Count by policyName\n| sort by Count desc\n| limit {{topKLimit}}"
        query_type   = "Logs"
      }

      title           = "Top {{topKLimit}} Policies Not Used in Past 30 Days"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"bar\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel241B4531AA66484C"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"policyViolated\",\"sidecar.name\",\"repo.name\",\"identity.endUser\" nodrop\n| where %\"policyViolated\" = \"true\" and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\"\n| count as Count by %\"identity.endUser\"\n| sort by Count desc\n| limit {{topKLimit}}"
        query_type   = "Logs"
      }

      title           = "Top {{topKLimit}} Users With Violations"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"bar\"},\"series\":{},\"overrides\":[],\"axes\":{\"axisX\":{\"title\":\"User\",\"hideLabels\":true},\"axisY\":{\"title\":\"Total Violations\"}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel26FADA66828C4A4C"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"policyViolated\",\"sidecar.name\",\"repo.name\",\"client.applicationName\" nodrop\n| where %\"policyViolated\" = \"true\" and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\"\n| count_distinct(%\"client.applicationName\")"
        query_type   = "Logs"
      }

      title           = "Apps With Violations"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"Applications\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel284E1754A0316A43"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"policyViolated\",\"request.statementType\",\"sidecar.name\",\"repo.name\",\"request.datasetsAccessed\",\"request.statement\" nodrop\n| where %\"policyViolated\" = \"false\" and %\"request.statementType\" = \"SELECT\" and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\" and isNull(%\"request.datasetsAccessed\")\n| count as Count by %\"repo.name\", %\"request.statement\"\n| sort by Count desc\n| limit {{topKLimit}}"
        query_type   = "Logs"
      }

      title           = "Top {{topKLimit}} Queries Without a Policy"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel2D533E1680B0184F"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"policyViolated\",\"sidecar.name\",\"repo.name\",\"request.datasetsAccessed\",\"request.statementType\" nodrop\n| where %\"policyViolated\" = \"false\" and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\" AND isNull(%\"request.datasetsAccessed\")\n| count as Count by %\"request.statementType\"\n| sum(Count) by %\"request.statementType\""
        query_type   = "Logs"
      }

      title           = "Statement Types Without Policy"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\"},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel399254B98CAB1945"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"policyViolated\",\"sidecar.name\",\"repo.name\" nodrop\n| where %\"policyViolated\" = \"true\" and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\"\n| count_distinct(%\"repo.name\")"
        query_type   = "Logs"
      }

      title           = "Repos With Violations"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"Repos\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel3E7CE173B07CF84B"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"policyViolated\",\"sidecar.name\",\"repo.name\",\"activityTime\",\"identity.endUser\",\"identity.group\",\"identity.repoUser\" nodrop\n| where %\"policyViolated\" matches \"*\" and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\"|first(%\"activityTime\") by %\"identity.endUser\", %\"identity.group\", %\"identity.repoUser\"\n| now()-30d as expireTime|parseDate(_first, \"yyyy-MM-dd HH:mm:ss\") as parsedDate\n| where expireTime > parsedDate\n| count"
        query_type   = "Logs"
      }

      title           = "Policies Not In Use"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Average\",\"label\":\"Policies\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"0\",\"hideData\":false,\"hideLabel\":false,\"rounding\":0,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel4697E69A9256484D"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"policyViolated\",\"sidecar.name\",\"repo.name\",\"identity.endUser\" nodrop\n| where %\"policyViolated\" = \"true\" and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\"\n| count_distinct(%\"identity.endUser\")"
        query_type   = "Logs"
      }

      title           = "Users With Violations"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"End Users\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel953EA468AC5AC84A"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"policyViolated\",\"request.statementType\",\"sidecar.name\",\"repo.name\",\"request.datasetsAccessed\",\"request.statement\",\"response.records\",\"client.connectionTime\",\"identity.group\",\"identity.endUser\",\"client.applicationName\",\"client.host\" nodrop\n| where %\"policyViolated\" = \"false\" and %\"request.statementType\" = \"SELECT\" and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\" and isNull(%\"request.datasetsAccessed\")\n| parse regex field=%\"request.statement\" \"^SELECT (?<Fields>.*) FROM (?<TableName>[a-z_\\.\\-A-Z$]*\\b)\"\n| count as Count, sum(%\"response.records\") as recordsRead by %\"repo.name\", %\"client.connectionTime\", %\"identity.group\", %\"identity.endUser\", %\"client.applicationName\", %\"client.host\", Fields, TableName\n| sort by Count asc\n| limit {{topKLimit}}"
        query_type   = "Logs"
      }

      title           = "Bottom {{topKLimit}} SELECT Queries Without a Policy"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel9FBED8429A57DB4D"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"policyViolated\",\"sidecar.name\",\"repo.name\" nodrop\n| where %\"policyViolated\" = \"true\" and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\"\n| json \"policyViolations[*].policyName\" as policyName\n| count as Violations by policyName\n| sort by Violations desc\n| limit {{topKLimit}}"
        query_type   = "Logs"
      }

      title           = "Top {{topKLimit}} Policies Violated"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"bar\"},\"series\":{},\"overrides\":[],\"axes\":{\"axisX\":{\"title\":\"Policy\",\"hideLabels\":true},\"axisY\":{\"title\":\"Total Violations\"}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelFE36F0048F90EB43"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"policyViolated\",\"sidecar.name\",\"repo.name\" nodrop\n| where %\"policyViolated\" = \"true\" and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\"\n| count"
        query_type   = "Logs"
      }

      title           = "Total Violations"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"Violations\",\"sparkline\":{\"show\":true,\"color\":\"\"},\"gauge\":{\"show\":false}}}"
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

  title = "Cyral - Policy Summary"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "repo_name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "repo_name"

    source_definition {
      log_query_variable_source_definition {
        field = "repo_name"
        query = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )\n|json \"repo.name\" as repo_name|count by repo_name"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "sidecar_name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "sidecar_name"

    source_definition {
      log_query_variable_source_definition {
        field = "sidecar_name"
        query = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )\n|json \"sidecar.name\" as sidecar_name|count by sidecar_name"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "5"
    display_name       = "topKLimit"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "topKLimit"

    source_definition {
      csv_variable_source_definition {
        values = "5,10,25,50,100"
      }
    }
  }
}

resource "sumologic_dashboard" "cyral_security_summary" {
  description = "Dashboard that provides high level information regarding suspicious activity."
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
        key       = "panel0431986CB55C4949"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panel068BB0DD976BEB43"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panel111599AEBC91D947"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panel9935851198257A48"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panelE1633FBE93F63A4D"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":6}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel0431986CB55C4949"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"activityTypes\",\"sidecar.name\",\"repo.name\",\"identity.repoUser\",\"identity.endUser\",\"activityTime\",\"client.host\",\"client.applicationName\" nodrop\n| where %\"activityTypes\" contains \"authenticationFailure\" and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\"\n| lookup type, actor, threatlevel from sumo://threat/cs on threat = %\"client.host\"\n| count as Count by %\"identity.repoUser\", %\"identity.endUser\", %\"repo.name\", %\"activityTime\", %\"client.host\",type,actor,threatlevel, %\"client.applicationName\"\n| sort by %\"activityTime\" desc\n| limit {{topKLimit}}"
        query_type   = "Logs"
      }

      title           = "{{topKLimit}} Most Recent Authentication Failures"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel068BB0DD976BEB43"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"activityTypes\",\"sidecar.name\",\"repo.name\" nodrop\n| where %\"activityTypes\" in (\"[\\\"authenticationFailure\\\"]\", \"[\\\"portScan\\\"]\") and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\"\n| timeslice\n| count by _timeslice, %\"activityTypes\"\n| transpose row _timeslice column %\"activityTypes\""
        query_type   = "Logs"
      }

      title           = "Suspicious Activity"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{\"A_[\\\"authenticationFailure\\\"]\":{\"visible\":true},\"A_[\\\"closedConnection\\\"]\":{\"visible\":true},\"A_[\\\"newConnection\\\"]\":{\"visible\":true},\"A_[\\\"portScan\\\"]\":{\"visible\":true},\"A_[\\\"query\\\",\\\"fullTableScan\\\"]\":{\"visible\":true},\"A_[\\\"query\\\"]\":{\"visible\":true}},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel111599AEBC91D947"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"activityTypes\",\"repo.name\",\"sidecar.name\" nodrop\n| where %\"activityTypes\" in (\"[\\\"authenticationFailure\\\"]\", \"[\\\"portScan\\\"]\") and !isNull(%\"repo.name\") and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\"\n| timeslice|count by _timeslice, %\"repo.name\"| transpose row _timeslice column %\"repo.name\""
        query_type   = "Logs"
      }

      title           = "Suspicious Activity By Repo"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel9935851198257A48"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"activityTypes\",\"sidecar.name\",\"repo.name\",\"client.host\" nodrop\n| where %\"activityTypes\" in (\"[\\\"authenticationFailure\\\"]\", \"[\\\"portScan\\\"]\") and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\"\n| lookup latitude, longitude from geo://location on ip=%\"client.host\" \n| count as Count by latitude, longitude\n| sort Count\n\n"
        query_type   = "Logs"
      }

      title           = "Suspicious Activity By Geography"
      visual_settings = "{\"general\":{\"mode\":\"map\",\"type\":\"map\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelE1633FBE93F63A4D"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )\n| json \"activityTypes\",\"sidecar.name\",\"repo.name\",\"client.host\" nodrop\n| where %\"activityTypes\" in (\"[\\\"authenticationFailure\\\"]\", \"[\\\"portScan\\\"]\") and %\"sidecar.name\" matches \"{{sidecar_name}}\" and %\"repo.name\" matches \"{{repo_name}}\"\n| lookup latitude, longitude, country_code from geo://location on ip=%\"client.host\"\n| lookup type, actor, threatlevel from sumo://threat/cs on threat = %\"client.host\"\n| count as Count by %\"client.host\", country_code, type, actor, threatlevel\n| sort by Count desc\n| limit {{topKLimit}}"
        query_type   = "Logs"
      }

      title           = "Top {{topKLimit}} Suspicious IPs"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
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

  title = "Cyral - Security Summary"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "repo_name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "repo_name"

    source_definition {
      log_query_variable_source_definition {
        field = "repo_name"
        query = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )\n|json \"repo.name\" as repo_name|count by repo_name"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "sidecar_name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "sidecar_name"

    source_definition {
      log_query_variable_source_definition {
        field = "sidecar_name"
        query = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )\n|json \"sidecar.name\" as sidecar_name|count by sidecar_name"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "5"
    display_name       = "topKLimit"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "topKLimit"

    source_definition {
      csv_variable_source_definition {
        values = "5, 10, 25, 50, 100"
      }
    }
  }
}

resource "sumologic_dashboard" "cyral_user_activity_details" {
  description = "Dashboard that provides specific information regarding a user."
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
        key       = "panel19FAB4BB8ABDEA4A"
        structure = "{\"height\":4,\"width\":6,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panel33893985BA142944"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":4}"
      }

      layout_structure {
        key       = "panel59636686B7F4FA4D"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":16}"
      }

      layout_structure {
        key       = "panel5EEA3E3EB7F3BB45"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":10}"
      }

      layout_structure {
        key       = "panel5F145873BF9CF949"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":22}"
      }

      layout_structure {
        key       = "panel600082A9BDE60B41"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":28}"
      }

      layout_structure {
        key       = "panel630E86FF9568484C"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":22}"
      }

      layout_structure {
        key       = "panel72DA3F04B63BB84A"
        structure = "{\"height\":4,\"width\":6,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panel8E37E9109A75DB46"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":10}"
      }

      layout_structure {
        key       = "panel8F5AE5CCB6DBF84E"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":16}"
      }

      layout_structure {
        key       = "panelB0776BCC9C5D094E"
        structure = "{\"height\":4,\"width\":6,\"x\":6,\"y\":0}"
      }

      layout_structure {
        key       = "panelC8AF40D289B5394A"
        structure = "{\"height\":4,\"width\":6,\"x\":18,\"y\":0}"
      }

      layout_structure {
        key       = "panelE4DE1B54B8788945"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":4}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel19FAB4BB8ABDEA4A"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"identity.endUser\",\"request.statementType\" nodrop\n| where !isNull(%\"identity.group\") and %\"identity.group\" matches \"{{Group}}\" and %\"identity.endUser\" matches \"{{endUser}}\" and %\"request.statementType\" matches \"{{statementType}}\"\n| json \"request.datasetsAccessed[*].accessType\" as accessType\n| where accessType CONTAINS \"read\"\n| count"
        query_type   = "Logs"
      }

      title           = "Total Reads"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"Reads\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel33893985BA142944"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"identity.endUser\",\"request.statementType\",\"response.records\" nodrop\n| where !isNull(%\"identity.group\") AND %\"identity.group\" matches \"{{Group}}\" and %\"identity.endUser\" matches \"{{endUser}}\" and %\"request.statementType\" matches \"{{statementType}}\"\n| sum(%\"response.records\") by %\"request.statementType\""
        query_type   = "Logs"
      }

      title           = "Statement Type Breakdown by Sum of Records"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel59636686B7F4FA4D"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )\n| json \"policyViolations[*].policyName\" as policyName nodrop\n| json \"policyViolations[*].severity\" as policySeverity nodrop\n| json \"policyViolations[*].accessType\" as policyAccessType nodrop\n| json \"identity.group\",\"identity.endUser\",\"request.statementType\",\"policyViolated\" nodrop\n| where %\"identity.group\" matches \"{{Group}}\" and %\"identity.endUser\" matches \"{{endUser}}\" and %\"request.statementType\" matches \"{{statementType}}\" and %\"policyViolated\"=\"true\"\n| count as Violations by policyName, policySeverity, policyAccessType\n| sort by Violations\n| limit {{topKLimit}}"
        query_type   = "Logs"
      }

      title           = "Top {{topKLimit}} Policy Violations"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel5EEA3E3EB7F3BB45"

      query {
        query_key    = "A"
        query_string = "((${var.scope_key}={{${var.scope_key_variable_display_name}}}  ))\n| json \"identity.group\",\"identity.endUser\",\"request.statementType\",\"response.records\",\"identity.repoUser\" nodrop\n| where %\"identity.group\" matches \"*\" AND %\"identity.group\" matches \"{{Group}}\" and %\"identity.endUser\" matches \"{{endUser}}\" and %\"request.statementType\" matches \"{{statementType}}\"\n| sum(%\"response.records\") as TotalRecords by %\"identity.repoUser\"\n| sort by TotalRecords desc\n| limit {{topKLimit}} "
        query_type   = "Logs"
      }

      title           = "Top {{topKLimit}}  Repo Users By Sum Records"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"bar\"},\"series\":{},\"overrides\":[],\"axes\":{\"axisX\":{\"title\":\"Repo User\",\"hideLabels\":true},\"axisY\":{\"title\":\"Total Records\"}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel5F145873BF9CF949"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"identity.endUser\",\"request.statementType\",\"response.records\",\"repo.name\" nodrop\n| where %\"identity.group\" matches \"{{Group}}\" and %\"identity.endUser\" matches \"{{endUser}}\" and (%\"request.statementType\"=\"DELETE\" or %\"request.statementType\"=\"INSERT\" or %\"request.statementType\"=\"UPDATE\")\n| json \"request.datasetsAccessed[*].accessType\" as accessType nodrop\n| json \"request.datasetsAccessed[*].dataset\" as dataSet nodrop\n| sum(%\"response.records\") as TotalRecords, count(accessType) as QueryTypes by %\"identity.endUser\", %\"repo.name\", dataSet"
        query_type   = "Logs"
      }

      title           = "Modifications"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel600082A9BDE60B41"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"identity.endUser\",\"request.statementType\",\"activityTime\",\"response.records\",\"response.bytes\",\"repo.name\",\"identity.repoUser\",\"client.connectionId\" nodrop\n| where %\"identity.group\" matches \"{{Group}}\" and %\"identity.endUser\" matches \"{{endUser}}\" and %\"request.statementType\" matches \"{{statementType}}\"\n| first(%\"activityTime\") as SessionStart, last(%\"activityTime\") as SessionEnd, sum(%\"response.records\") as Records, sum(%\"response.bytes\") as Bytes by %\"repo.name\", %\"identity.repoUser\", %\"identity.group\", %\"client.connectionId\"\n| sort by SessionEnd desc\n| limit {{topKLimit}} "
        query_type   = "Logs"
      }

      title           = "{{topKLimit}}  Most Recent Sessions by Session End"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel630E86FF9568484C"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"request.datasetsAccessed[*].accessType\" as dataSetAccessType nodrop\n| json \"request.datasetsAccessed[*].dataset\" as dataSetAccessedDataSet nodrop\n| json \"identity.group\",\"repo.name\",\"response.records\",\"identity.endUser\",\"request.statementType\" nodrop\n| where dataSetAccessType contains \"read\" and %\"identity.group\" matches \"{{Group}}\" and %\"identity.endUser\" matches \"{{endUser}}\" and %\"request.statementType\" matches \"{{statementType}}\"\n| count(dataSetAccessType) as QueryTypes, sum(%\"response.records\") as TotalRecords by %\"identity.endUser\", %\"repo.name\", dataSetAccessedDataSet\n| sort by QueryTypes\n| limit {{topKLimit}}"
        query_type   = "Logs"
      }

      title           = "Data Reads Breakdown"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel72DA3F04B63BB84A"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"response.message\",\"identity.endUser\",\"request.statementType\",\"response.records\" nodrop\n| where !isNull(%\"identity.group\") and !isNull(%\"response.message\") and %\"identity.group\" matches \"{{Group}}\" and %\"identity.endUser\" matches \"{{endUser}}\" and %\"request.statementType\" matches \"{{statementType}}\"\n| avg(%\"response.records\")"
        query_type   = "Logs"
      }

      title           = "Avg Records Read"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Average\",\"label\":\"Records\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":0,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8E37E9109A75DB46"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"identity.endUser\",\"request.statementType\",\"response.records\",\"repo.name\" nodrop\n| where %\"identity.group\" matches \"*\" AND %\"identity.group\" matches \"{{Group}}\" and %\"identity.endUser\" matches \"{{endUser}}\" and %\"request.statementType\" matches \"{{statementType}}\"\n| sum(%\"response.records\") as TotalRecords by %\"repo.name\"\n| sort by TotalRecords desc\n| limit {{topKLimit}} "
        query_type   = "Logs"
      }

      title           = "Top {{topKLimit}}  Repos By Sum Records"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"bar\"},\"series\":{},\"overrides\":[],\"axes\":{\"axisX\":{\"title\":\"Repo Name\",\"hideLabels\":true},\"axisY\":{\"title\":\"Total Records\"}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8F5AE5CCB6DBF84E"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"identity.endUser\",\"request.statementType\",\"response.records\",\"client.applicationName\" nodrop\n| where %\"identity.group\" matches \"{{Group}}\" and %\"identity.endUser\" matches \"{{endUser}}\" and %\"request.statementType\" matches \"{{statementType}}\"\n| sum(%\"response.records\") as TotalRecords by %\"client.applicationName\"\n| sort by TotalRecords desc\n| limit {{topKLimit}} "
        query_type   = "Logs"
      }

      title           = "Top {{topKLimit}} Applications by Sum Records"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"bar\"},\"series\":{},\"overrides\":[],\"axes\":{\"axisX\":{\"title\":\"Application Name\",\"hideLabels\":true},\"axisY\":{\"title\":\"_sum\",\"hideLabels\":false}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB0776BCC9C5D094E"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n|json \"identity.group\",\"response.message\",\"identity.endUser\",\"request.statementType\",\"response.executionTimeNanos\" nodrop\n| where !isNull(%\"identity.group\") and !isNull(%\"response.message\") and %\"identity.group\" matches \"{{Group}}\" and %\"identity.endUser\" matches \"{{endUser}}\" and %\"request.statementType\" matches \"{{statementType}}\"\n| %\"response.executionTimeNanos\" / 1000000 as executionTimeInMS\n| avg(executionTimeInMS)"
        query_type   = "Logs"
      }

      title           = "Avg Execution Time"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Average\",\"label\":\"ms\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelC8AF40D289B5394A"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"identity.endUser\",\"request.statementType\",\"response.bytes\" nodrop\n| where !isNull(%\"identity.group\") and !isNull(%\"response.message\") and %\"identity.group\" matches \"{{Group}}\" and %\"identity.endUser\" matches \"{{endUser}}\" and %\"request.statementType\" matches \"{{statementType}}\"\n| avg(%\"response.bytes\")"
        query_type   = "Logs"
      }

      title           = "Avg Bytes Read"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"Bytes\",\"rounding\":0}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelE4DE1B54B8788945"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"identity.group\",\"identity.endUser\",\"request.statementType\",\"response.records\" nodrop\n| where !isNull(%\"identity.group\") AND %\"identity.group\" matches \"{{Group}}\" and %\"identity.endUser\" matches \"{{endUser}}\" and %\"request.statementType\" matches \"{{statementType}}\"\n| timeslice 15m\n| sum(%\"response.records\") by _timeslice, %\"request.statementType\"\n| transpose row _timeslice column %\"request.statementType\""
        query_type   = "Logs"
      }

      title           = "User Statement Type Trend by Sum of Records"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\"},\"series\":{\"A_DELETE\":{\"visible\":true}},\"overrides\":[]}"
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

  title = "Cyral - User Activity Details"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "Group"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "Group"

    source_definition {
      log_query_variable_source_definition {
        field = "groupName"
        query = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}   )|json \"identity.group\" as groupName|where groupName matches \"*\"|count by groupName"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "endUser"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "endUser"

    source_definition {
      log_query_variable_source_definition {
        field = "endUser"
        query = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}   )\n|json \"identity.endUser\"as endUser|where endUser matches \"*\"|count by endUser"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "statementType"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "statementType"

    source_definition {
      log_query_variable_source_definition {
        field = "statementType"
        query = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}   )\n|json \"request.statementType\" as statementType|where statementType matches \"*\"|count by statementType"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "5"
    display_name       = "topKLimit"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "topKLimit"

    source_definition {
      csv_variable_source_definition {
        values = "5,10,25,50,100"
      }
    }
  }
}
