resource "sumologic_dashboard" "lambda_test_test_error_overview" {
  description = "This dashboard shows overview of test error execution details."
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
        key       = "panel35DD97049B83D848"
        structure = "{\"height\":12,\"width\":12,\"x\":12,\"y\":15}"
      }

      layout_structure {
        key       = "panelAADB4D689ADBFA44"
        structure = "{\"height\":6,\"width\":6,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelABDE0B06ADBA394C"
        structure = "{\"height\":6,\"width\":6,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panelD1B2E70FBE7DE84B"
        structure = "{\"height\":12,\"width\":12,\"x\":0,\"y\":15}"
      }

      layout_structure {
        key       = "panelED7A87F3AF63B946"
        structure = "{\"height\":6,\"width\":6,\"x\":18,\"y\":0}"
      }

      layout_structure {
        key       = "panelFC000A36B6224849"
        structure = "{\"height\":6,\"width\":6,\"x\":6,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-244B3AF3AAF30B4D"
        structure = "{\"height\":9,\"width\":24,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-28073A72BB72C848"
        structure = "{\"height\":9,\"width\":12,\"x\":12,\"y\":37}"
      }

      layout_structure {
        key       = "panelPANE-C4EBD40AAE4AE944"
        structure = "{\"height\":10,\"width\":24,\"x\":0,\"y\":27}"
      }

      layout_structure {
        key       = "panelPANE-F17ECC239438984B"
        structure = "{\"height\":9,\"width\":12,\"x\":0,\"y\":37}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel35DD97049B83D848"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where !isNull(test_id) and !isBlank(error_message) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" | error_message as Error_Message | count as Total_Errors by Error_Message | sort by Total_Errors desc"
        query_type   = "Logs"
      }

      title           = "Error Message Categorization"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"legend\":{\"enabled\":false},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelAADB4D689ADBFA44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where status in (\"Lambda Error\", \"Queue_timeout\", \"Idle_timeout\") and !isNull(test_id) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\"\n| timeslice 10m | count by _timeslice | sort _timeslice asc"
        query_type   = "Logs"
      }

      title           = "Total errors "
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Sum\",\"label\":\"Test errors\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":true,\"color\":\"#8be2ff\"},\"gauge\":{\"show\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelABDE0B06ADBA394C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where status = \"Queue_Timeout\" AND !isNull(test_id)  and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" | timeslice 10m | count by _timeslice | sort _timeslice asc"
        query_type   = "Logs"
      }

      title           = "Queue Timeout"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Sum\",\"label\":\"Queue Timeout\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":true,\"color\":\"#8be2ff\"},\"gauge\":{\"show\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelD1B2E70FBE7DE84B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where !isNull(test_id) and !isBlank(error_message) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" | count by error_message | sort by _count"
        query_type   = "Logs"
      }

      title           = "Error Message Categorization"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"legend\":{\"enabled\":false},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":5,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelED7A87F3AF63B946"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where status = \"Lambda Error\" AND !isNull(test_id)  and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" | timeslice 10m | count by _timeslice | sort _timeslice asc"
        query_type   = "Logs"
      }

      title           = "Lambda Error"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Sum\",\"label\":\"Lambda Error\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":true,\"color\":\"#8be2ff\"},\"gauge\":{\"show\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelFC000A36B6224849"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where status = \"Idle_Timeout\" AND !isNull(test_id) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" | timeslice 10m | count by _timeslice | sort _timeslice asc"
        query_type   = "Logs"
      }

      title           = "Idle Timeout"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Sum\",\"label\":\"Idle Timeout\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":true,\"color\":\"#8be2ff\"},\"gauge\":{\"show\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-244B3AF3AAF30B4D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where !isNull(test_id) AND !isBlank(error_type) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\"\n| timeslice {{Timeslice}}\n| count by error_type,_timeslice\n| transpose row _timeslice column error_type"
        query_type   = "Logs"
      }

      title           = "Error Stats"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{\"A_session-expired\":{\"visible\":false}},\"overrides\":[],\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-28073A72BB72C848"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" | if (status in (\"Idle_Timeout\", \"Queue_Timeout\", \"Lambda Error\"),1,0) as is_failed | count by test_name, is_failed | count by test_name | where _count > 1 | limit 10 | fields test_name"
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

      title           = "Top 10 Flaky Tests"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"fillOpacity\":0.25,\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-C4EBD40AAE4AE944"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where !isNull(test_id) AND !isNull(status) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" \n| if (status in (\"Lambda Error\", \"Queue_Timeout\", \"Idle_Timeout\"), \"Failed\", \"Success\") as final_status\n| timeslice {{Timeslice}}\n| count by final_status,_timeslice\n| transpose row _timeslice column final_status"
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

      title           = "Test Status Ratio"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Time\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"Test Status\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false},\"axisY2\":{\"unitDecimals\":0,\"title\":\"\"}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-F17ECC239438984B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where status in (\"Idle_Timeout\", \"Queue_Timeout\", \"Lambda Error\") and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" | timeslice 1h | count by test_name, _timeslice | transpose row _timeslice column test_name"
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

      title           = "Test Failure by Name"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"},\"overrides\":[]}"
    }
  }

  refresh_interval = "0"
  theme            = "Dark"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-15m"
        }
      }
    }
  }

  title = "LambdaTest - Test Error Overview"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "Build_Name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "Build_Name"

    source_definition {
      log_query_variable_source_definition {
        field = "build_name"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | json \"build_name\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "Test_Name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "Test_Name"

    source_definition {
      log_query_variable_source_definition {
        field = "test_name"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | json \"test_name\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "1h"
    display_name       = "Timeslice"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "Timeslice"

    source_definition {
      csv_variable_source_definition {
        values = "5m,1h, 6h, 12h, 24h"
      }
    }
  }
}

resource "sumologic_dashboard" "lambda_test_test_overview" {
  description = "This dashboard shows overview of test execution details."
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
        key       = "panel2B166CB080F29A42"
        structure = "{\"height\":11,\"width\":24,\"x\":0,\"y\":37}"
      }

      layout_structure {
        key       = "panel613400C2A005F845"
        structure = "{\"height\":8,\"width\":8,\"x\":8,\"y\":0}"
      }

      layout_structure {
        key       = "panel69C3C8FA9995B949"
        structure = "{\"height\":11,\"width\":12,\"x\":12,\"y\":14}"
      }

      layout_structure {
        key       = "panel9679E61394DD0B46"
        structure = "{\"height\":12,\"width\":12,\"x\":12,\"y\":25}"
      }

      layout_structure {
        key       = "panelB488CB66A791AA4F"
        structure = "{\"height\":8,\"width\":8,\"x\":16,\"y\":0}"
      }

      layout_structure {
        key       = "panelB63FC36F95F6CB44"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":8}"
      }

      layout_structure {
        key       = "panelC7C6E23B891F2844"
        structure = "{\"height\":8,\"width\":8,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelCA8BB39B9991984D"
        structure = "{\"height\":11,\"width\":24,\"x\":0,\"y\":48}"
      }

      layout_structure {
        key       = "panelPANE-22164754AA21EB47"
        structure = "{\"height\":11,\"width\":12,\"x\":0,\"y\":14}"
      }

      layout_structure {
        key       = "panelPANE-34B98E3A87D4B848"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":8}"
      }

      layout_structure {
        key       = "panelPANE-B872022B81A2FA4A"
        structure = "{\"height\":12,\"width\":12,\"x\":0,\"y\":25}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel2B166CB080F29A42"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| timeslice {{Timeslice}} | where !isNull(test_id) AND !isNull(test_started_at) AND !isNull(test_ended_at) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\"\n// Convert the two fields defining the start and end of each test to milliseconds\n| count as Test_Execution_Count by _timeslice\n| sort by _timeslice asc\n| fillmissing timeslice({{Timeslice}})\n| compare with timeshift {{Timeshift}}"
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

      title           = "Test Execution Trend"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel613400C2A005F845"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where status = \"Completed\" AND !isNull(test_id) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" | timeslice 10m | count by _timeslice | sort _timeslice asc"
        query_type   = "Logs"
      }

      title           = "Tests Completed"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Sum\",\"label\":\"Completed\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":1,\"to\":null,\"color\":\"#8be2ff\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":true,\"color\":\"#8be2ff\"},\"gauge\":{\"show\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel69C3C8FA9995B949"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where !isNull(test_id) and !isBlank(test_env_browser) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" | test_env_browser as Test_Browser | count as Total_Tests by Test_Browser | sort by Total_Tests desc"
        query_type   = "Logs"
      }

      title           = "Tests by Browser"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"legend\":{\"enabled\":false},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel9679E61394DD0B46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where !isNull(test_id) and !isBlank(test_env_os) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" | test_env_os as Test_OS | count as Total_Tests by Test_OS | sort by Total_Tests desc"
        query_type   = "Logs"
      }

      title           = "Tests by Operating Systems"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"legend\":{\"enabled\":false},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB488CB66A791AA4F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where status = \"Passed\" AND !isNull(test_id) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" | timeslice 10m | count by _timeslice | sort _timeslice asc"
        query_type   = "Logs"
      }

      title           = "Tests Passed"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Sum\",\"label\":\"Passed\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":1,\"to\":null,\"color\":\"#16943e\"},{\"from\":null,\"to\":null,\"color\":\"#dfbe2e\"},{\"from\":null,\"to\":null,\"color\":\"#bf2121\"}],\"sparkline\":{\"show\":true,\"color\":\"#16943e\"},\"gauge\":{\"show\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB63FC36F95F6CB44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where status = \"Failed\" AND !isNull(test_id) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" | timeslice 10m | count by _timeslice | sort _timeslice asc"
        query_type   = "Logs"
      }

      title           = "Tests Failed"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Sum\",\"label\":\"Failed\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":1,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":true,\"color\":\"#bf2121\"},\"gauge\":{\"show\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelC7C6E23B891F2844"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where !isNull(test_id) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" | timeslice 10m | count by _timeslice | sort _timeslice asc"
        query_type   = "Logs"
      }

      title           = "Test Runs"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Sum\",\"label\":\"Tests\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":true,\"color\":\"#ffffff\"},\"gauge\":{\"show\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelCA8BB39B9991984D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| {{Timeslice}} as time_delta | where !isNull(test_id) AND !isNull(test_started_at) AND !isNull(test_ended_at) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\"\n// Convert the two fields defining the start and end of each test to milliseconds\n| parseDate(test_created_at, \"yyyy-MM-dd HH:mm:ss\",\"UTC\") as create_milliseconds\n| parseDate(test_started_at, \"yyyy-MM-dd HH:mm:ss\",\"UTC\") as start_milliseconds\n// Calculate the previous timeslice before the test began\n| floor(create_milliseconds/time_delta)*time_delta as first_timeslice\n// Calculate the next timeslice after the test ended\n| ceil(start_milliseconds/time_delta)*time_delta as last_timeslice\n// Calculate how many timeslices the test spanned\n| (last_timeslice - first_timeslice)/time_delta as intervals\n// Generate a string comprising \"1\"'s with a length that is equivalent to the number of intervals\n| substring(replace(format(\"%.0f\",pow(10,intervals -1)),\"0\",\"1\"),0,intervals) as series_of_ones\n// Replicate the message once for each interval\n| parse regex field=series_of_ones \"(?<one_per_time_slice>[0-9])\" multi\n// Use the accum operator to create a sequence of numbers\n| accum one_per_time_slice as counter by test_id\n// Calculate the time representing each timeslice\n| first_timeslice + counter * time_delta as start_of_timeslice\n// Optionally format as a date for verification \n//| formatDate(toLong(start_of_timeslice),\"yyyy-MM-dd HH:mm:ss\",\"UTC\") as start_of_timeslice_formatted\n// Assign to the _timeslice field so that it gets treated as a time series.\n| start_of_timeslice as _timeslice\n// Aggregate over time (there will only be one instance of a test_id per timeslice\n| count as Queue_Usage by _timeslice\n| sort by _timeslice asc\n| fillmissing timeslice({{Timeslice}})\n| compare with timeshift {{Timeshift}}"
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

      title           = "Queue Usage Trend"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-22164754AA21EB47"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where !isNull(test_id) and !isBlank(test_env_browser) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" | count by test_env_browser | sort by _count"
        query_type   = "Logs"
      }

      title           = "Top 10 - Tests by Browser"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-34B98E3A87D4B848"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where status in (\"Lambda Error\",\"Queue_timeout\",\"Idle_timeout\")\n| where !isNull(test_id) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\"\n| timeslice 10m | count by _timeslice | sort _timeslice asc "
        query_type   = "Logs"
      }

      title           = "Test Errored"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Sum\",\"label\":\"Errored\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":1,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":true,\"color\":\"#bf2121\"},\"gauge\":{\"show\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-B872022B81A2FA4A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| where !isNull(test_id) and !isBlank(test_env_os) and test_name matches \"{{Test_Name}}\" and build_name matches \"{{Build_Name}}\" | count by test_env_os | sort by _count"
        query_type   = "Logs"
      }

      title           = "Top 10 - Tests by Operating System"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":5},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  refresh_interval = "0"
  theme            = "Dark"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-15m"
        }
      }
    }
  }

  title = "LambdaTest - Test Overview"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "Build_Name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "Build_Name"

    source_definition {
      log_query_variable_source_definition {
        field = "build_name"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | json \"build_name\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "Test_Name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "Test_Name"

    source_definition {
      log_query_variable_source_definition {
        field = "test_name"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | json \"test_name\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "1d"
    display_name       = "Timeshift"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "Timeshift"

    source_definition {
      csv_variable_source_definition {
        values = "1h,1d, 7d,15d,30d"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "1h"
    display_name       = "Timeslice"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "Timeslice"

    source_definition {
      csv_variable_source_definition {
        values = "5m,1h, 6h, 12h, 24h"
      }
    }
  }
}
