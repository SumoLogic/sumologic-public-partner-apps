resource "sumologic_dashboard" "sauce_labs_vdc" {
  description = "Integrate your Sauce Labs test data with the Sumo Logic Analytics Platform to easily aggregate, visualize, and monitor all of your test data. Connect Sauce Labs data with other data sources for a comprehensive view of your development pipeline."
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
        key       = "panel34EFEAF0917EF845"
        structure = "{\"height\":4,\"width\":6,\"x\":18,\"y\":0}"
      }

      layout_structure {
        key       = "panel4279124A8E5AB942"
        structure = "{\"height\":9,\"width\":12,\"x\":0,\"y\":19}"
      }

      layout_structure {
        key       = "panel7C71993F88CB194B"
        structure = "{\"height\":4,\"width\":6,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panel8B492D548EF17A4C"
        structure = "{\"height\":9,\"width\":12,\"x\":12,\"y\":19}"
      }

      layout_structure {
        key       = "panelE3708DD891F88A4C"
        structure = "{\"height\":4,\"width\":6,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelE7B93E58B9CDDA4D"
        structure = "{\"height\":7,\"width\":12,\"x\":12,\"y\":28}"
      }

      layout_structure {
        key       = "panelF01DD38D8DB8EA44"
        structure = "{\"height\":7,\"width\":12,\"x\":0,\"y\":28}"
      }

      layout_structure {
        key       = "panelF637667CAB145947"
        structure = "{\"height\":4,\"width\":6,\"x\":6,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-26D7D2169637A849"
        structure = "{\"height\":7,\"width\":12,\"x\":12,\"y\":4}"
      }

      layout_structure {
        key       = "panelPANE-27E58DF9AFBDAA40"
        structure = "{\"height\":6,\"width\":24,\"x\":0,\"y\":35}"
      }

      layout_structure {
        key       = "panelPANE-370B11E78B942941"
        structure = "{\"height\":8,\"width\":12,\"x\":12,\"y\":11}"
      }

      layout_structure {
        key       = "panelPANE-9742013E8C4B3A43"
        structure = "{\"height\":8,\"width\":12,\"x\":0,\"y\":11}"
      }

      layout_structure {
        key       = "panelPANE-BCB929608441D84B"
        structure = "{\"height\":7,\"width\":12,\"x\":0,\"y\":4}"
      }

      layout_structure {
        key       = "panelPANE-F7FDEA49931EE84C"
        structure = "{\"height\":2,\"width\":24,\"x\":0,\"y\":41}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel34EFEAF0917EF845"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"id\", \"status\", \"data_type\" as job_id, status, data_type\n| where (status matches /errored/ and data_type matches \"vdc_test\")\n| count(job_id) "
        query_type   = "Logs"
      }

      title           = "VDC Tests errored"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Sum\",\"label\":\"test errored\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":50,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel4279124A8E5AB942"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"id\", \"status\", \"data_type\" as job_id, status, data_type\n| where (status matches /complete|errored|passed|failed/ and data_type matches \"vdc_test\")\n| count(job_id) by status"
        query_type   = "Logs"
      }

      title           = "VDC Tests by status "
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel7C71993F88CB194B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"id\", \"status\", \"data_type\" as job_id, status, data_type\n| where (status matches /failed/ and data_type matches \"vdc_test\")\n| count(job_id) "
        query_type   = "Logs"
      }

      title           = "VDC Tests failed"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Sum\",\"label\":\"test failed\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":50,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8B492D548EF17A4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"browser_name\", \"browser_version\", \"data_type\", \"os_name\", \"os_version\", \"status\", \"id\" as browser, browserVersion, data_type, os, osVersion, status, job_id\n| where (status matches /errored|failed/ and data_type matches \"vdc_test\")\n| concat (browser, \" \", browserVersion, \" \", os, \" \", osVersion) as browserOs\n| count(job_id) by browserOs"
        query_type   = "Logs"
      }

      title           = "VDC Tests failed and errored by browser/os count"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"showAsTable\":false},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelE3708DD891F88A4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"id\", \"status\", \"data_type\" as job_id, status, data_type\n| where (status matches /complete|errored|passed|failed/ and data_type matches \"vdc_test\")\n| count(job_id)"
        query_type   = "Logs"
      }

      title           = "VDC Tests run total"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Sum\",\"label\":\"test total\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":50,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelE7B93E58B9CDDA4D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"id\", \"status\", \"data_type\", \"automation_backend\" as job_id, status, data_type, framework\n| where (status matches /complete|errored|passed|failed/ and data_type matches \"vdc_test\")\n| timeslice 15m as _timeslice\n| count(job_id) by _timeslice, framework\n| transpose row _timeslice column framework"
        query_type   = "Logs"
      }

      title           = "VDC Tests by framework"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"Number of tests\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false},\"axisY2\":{\"title\":\"Date\"}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{\"A_Chrome 93.0 Windows 10\":{\"visible\":true},\"A_Chrome beta.0 Windows 10\":{\"visible\":true},\"A_Firefox 92.0 Windows 10\":{\"visible\":true}},\"overrides\":[],\"general\":{\"type\":\"area\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"fillOpacity\":0.25,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelF01DD38D8DB8EA44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"id\", \"status\", \"data_type\", \"team_name\" as job_id, status, data_type, team_name\n| where (status matches /errored|failed/ and data_type matches \"vdc_test\")\n| count(job_id) by team_name"
        query_type   = "Logs"
      }

      title           = "VDC Tests failed and errored by team"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"Team name\",\"hideLabels\":true},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"title\":\"Test failed\",\"hideLabels\":false}},\"series\":{},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"showAsTable\":false},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelF637667CAB145947"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"id\", \"status\", \"data_type\" as job_id, status, data_type\n| where (status matches /passed/ and data_type matches \"vdc_test\")\n| count(job_id) "
        query_type   = "Logs"
      }

      title           = "VDC Tests passed"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Sum\",\"label\":\"test passed\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":50,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-26D7D2169637A849"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"duration_sec\", \"status\", \"data_type\" as duration, status, data_type\n| where (status matches /complete|errored|passed|failed/ and data_type matches \"vdc_test\")\n| timeslice 1h as _timeslice\n| avg(duration) as avg_duration by _timeslice"
        query_type   = "Logs"
      }

      title           = "Average runtime of VDC tests by date"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Date\",\"titleFontSize\":12,\"labelFontSize\":12,\"hideLabels\":false},\"axisY\":{\"title\":\"Average test duration\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"unit\":{\"value\":\"s\",\"isCustom\":false},\"unitDecimals\":0}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-27E58DF9AFBDAA40"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"id\", \"team_name\", \"status\", \"data_type\", \"modification_time\", \"sl_url\" as job_id, team_name, status, data_type, modification_time, sl_url\n| tourl(concat(sl_url, \"?utm_source=sl_sumo_app\"), \"Job Details\") as sl_link\n| where (status matches /errored|failed/ and data_type matches \"vdc_test\")\n| count by job_id, team_name, sl_link, modification_time\n| top 10 team_name, job_id, sl_link by modification_time"
        query_type   = "Logs"
      }

      title           = "Most recent failed VDC tests"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"timeSeries\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-370B11E78B942941"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"browser_name\", \"browser_version\", \"data_type\", \"os_name\", \"os_version\", \"status\", \"id\" as browser, browserVersion, data_type, os, osVersion, status, job_id\n| where (status matches /complete|errored|passed|failed/ and data_type matches \"vdc_test\")\n| concat (browser, \" \", browserVersion, \" \", os, \" \", osVersion) as browserOs\n| timeslice 15m as _timeslice\n| count(job_id) by _timeslice, browserOs\n| transpose row _timeslice column browserOs"
        query_type   = "Logs"
      }

      title           = "VDC Tests Browser/Os count"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Date\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"Number of tests\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"hideLabels\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{\"A_Chrome 93.0 Windows 10\":{\"visible\":true},\"A_Chrome beta.0 Windows 10\":{\"visible\":true},\"A_Firefox 92.0 Windows 10\":{\"visible\":true}},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-9742013E8C4B3A43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"id\", \"status\", \"data_type\" as job_id, status, data_type\n| where (status matches /complete|errored|passed|failed/ and data_type matches \"vdc_test\")\n| timeslice 15m as _timeslice \n| count(job_id) by _timeslice, status\n| transpose row _timeslice column status"
        query_type   = "Logs"
      }

      title           = "VDC Tests per status count"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Date\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"Number of tests\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false},\"axisY2\":{\"title\":\"Number of tests\"}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{\"A_complete\":{\"visible\":true},\"A_errored\":{\"visible\":true},\"A_failed\":{\"visible\":true},\"A_passed\":{\"visible\":true}},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-BCB929608441D84B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"id\", \"status\", \"data_type\" as job_id, status, data_type\n| where (status matches /complete|errored|passed|failed/ and data_type matches \"vdc_test\")\n| timeslice 15m as _timeslice \n| count(job_id) by _timeslice"
        query_type   = "Logs"
      }

      title           = "Number of VDC tests by date"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"Date\",\"titleFontSize\":12,\"labelFontSize\":12,\"hideLabels\":false},\"axisY\":{\"title\":\"Number of tests\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"},\"overrides\":[]}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-F7FDEA49931EE84C"
      text                                        = "Powered by [Sauce Labs](https://saucelabs.com)"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"series\":{},\"legend\":{\"enabled\":false},\"text\":{\"format\":\"markdownV2\",\"horizontalAlignment\":\"right\",\"verticalAlignment\":\"center\",\"fontSize\":20,\"showTitle\":false}}"
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

  title = "Sauce Labs - VDC"
}
