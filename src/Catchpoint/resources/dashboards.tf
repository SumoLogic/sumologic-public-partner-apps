resource "sumologic_dashboard" "catchpoint_overview" {
  description = "The Overview dashboard is your central location for the Catchpoint tests in your account. View at-a-glance information surrounding your recent Errors and the Tests widget lets you search for and quickly access your synthetic data."
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
        key       = "panel1FDD8837A1DA7940"
        structure = "{\"height\":4,\"width\":3,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panel29FC803CAEBC6B46"
        structure = "{\"height\":4,\"width\":3,\"x\":18,\"y\":0}"
      }

      layout_structure {
        key       = "panel4CA49121B4FFF849"
        structure = "{\"height\":4,\"width\":3,\"x\":9,\"y\":0}"
      }

      layout_structure {
        key       = "panel4FCFF5A8B7613A43"
        structure = "{\"height\":4,\"width\":3,\"x\":6,\"y\":0}"
      }

      layout_structure {
        key       = "panel9A097866AC419A4A"
        structure = "{\"height\":10,\"width\":12,\"x\":12,\"y\":4}"
      }

      layout_structure {
        key       = "panelB9F776469B641840"
        structure = "{\"height\":4,\"width\":3,\"x\":21,\"y\":0}"
      }

      layout_structure {
        key       = "panelC9DB447C8F83DA4F"
        structure = "{\"height\":4,\"width\":6,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelCEAC3F049302384C"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":14}"
      }

      layout_structure {
        key       = "panelD2092B49AF97EA4C"
        structure = "{\"height\":4,\"width\":3,\"x\":15,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-1694AD549570694E"
        structure = "{\"height\":10,\"width\":24,\"x\":0,\"y\":20}"
      }

      layout_structure {
        key       = "panelPANE-5FC90D03966B8943"
        structure = "{\"height\":10,\"width\":12,\"x\":0,\"y\":4}"
      }

      layout_structure {
        key       = "panelPANE-88755EF8BAF9C94C"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":14}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel1FDD8837A1DA7940"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary.Error.Code\" as Errors\n| if(Errors matches \"50005\", 1,0) as Timeout_errors\n| sum(Timeout_errors) as Timeout_errors\n"
        query_type   = "Logs"
      }

      title           = "# Timeout Errors"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Average\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":0,\"to\":1,\"color\":\"#8ecc1b\"},{\"from\":1,\"to\":25,\"color\":\"#DFBE2E\"},{\"from\":25,\"to\":100,\"color\":\"#ff5d5d\"}],\"sparkline\":{\"show\":false},\"gauge\":{\"show\":false,\"min\":0,\"max\":100}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel29FC803CAEBC6B46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   | json field=_raw \"Summary.Error.Code\" as Errors   | if(Errors matches \"50112\", 1,0) as Transaction_Errors | sum(Transaction_Errors) as Transaction_Errors \n\n"
        query_type   = "Logs"
      }

      title           = "# Transaction Errors"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Average\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":0,\"to\":1,\"color\":\"#8ecc1b\"},{\"from\":1,\"to\":25,\"color\":\"#DFBE2E\"},{\"from\":25,\"to\":100,\"color\":\"#ff5d5d\"}],\"sparkline\":{\"show\":false},\"gauge\":{\"show\":false,\"min\":0,\"max\":100}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel4CA49121B4FFF849"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary.Error.Code\" as Errors\n| if(Errors matches \"50011\", 1,0) as Connection_Errors\n| if(Errors matches \"50005\", 1,0) as Timeout_errors\n| sum(Connection_Errors) as Connection_Errors"
        query_type   = "Logs"
      }

      title           = "# Connection Errors"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Average\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":0,\"to\":1,\"color\":\"#8ecc1b\"},{\"from\":1,\"to\":25,\"color\":\"#DFBE2E\"},{\"from\":25,\"to\":100,\"color\":\"#ff5d5d\"}],\"sparkline\":{\"show\":false},\"gauge\":{\"show\":false,\"min\":0,\"max\":100}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel4FCFF5A8B7613A43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| json field=_raw \"Summary.Error.Code\" as Errors\n| if(Errors matches \"50010\", 1,0) as DNS_Errors\n| sum(DNS_Errors) as DNS_Errors "
        query_type   = "Logs"
      }

      title           = "# DNS Errors"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Average\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":0,\"to\":1,\"color\":\"#8ecc1b\"},{\"from\":1,\"to\":25,\"color\":\"#DFBE2E\"},{\"from\":25,\"to\":100,\"color\":\"#ff5d5d\"}],\"sparkline\":{\"show\":false},\"gauge\":{\"show\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel9A097866AC419A4A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| _sourcehost as ip_address\n| count by ip_address \n| lookup latitude, longitude, country_code, country_name, region, city, postal_code from geo://location on ip = ip_address\n"
        query_type   = "Logs"
      }

      title           = "Test Runs by Node"
      visual_settings = "{\"general\":{\"mode\":\"map\",\"type\":\"map\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"series\":{},\"map\":{\"layerType\":\"Cluster\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB9F776469B641840"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   | json field=_raw \"Summary.Error.Code\" as Errors   | if(Errors matches \"50010\", 1,0) as DNS_Errors | if(Errors matches \"50011\", 1,0) as Connection_Errors | if(Errors matches /^((?!((50010.*)|(50011.*)|(50005.*)|(12175.*)|(50112.*))).)*$/, 1,0) as Other_errors | sum(Other_errors) as Other_errors \n\n"
        query_type   = "Logs"
      }

      title           = "# Other Errors"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Average\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":0,\"to\":1,\"color\":\"#8ecc1b\"},{\"from\":1,\"to\":25,\"color\":\"#DFBE2E\"},{\"from\":25,\"to\":100,\"color\":\"#ff5d5d\"}],\"sparkline\":{\"show\":false},\"gauge\":{\"show\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelC9DB447C8F83DA4F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| json field=_raw \"Summary.Error.Code\" as Errors \n| if(Errors matches /\\d*/,1,0) as Error_Count \n| sum(Error_Count) as Error_Count"
        query_type   = "Logs"
      }

      title           = "# Errors"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Average\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":0,\"to\":1,\"color\":\"#8ecc1b\"},{\"from\":1,\"to\":25,\"color\":\"#DFBE2E\"},{\"from\":25,\"to\":100,\"color\":\"#ff5d5d\"}],\"sparkline\":{\"show\":false},\"gauge\":{\"show\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelCEAC3F049302384C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   | json field=_raw \"Summary.Error.Code\" as Errors | if(Errors matches \"50010\", 1,0) as Errors_Count | timeslice 1m |sum(Errors_Count) as DNS_Errors by _timeslice"
        query_type   = "Logs"
      }

      query {
        query_key    = "B"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | json field=_raw \"Summary.Error.Code\" as Errors   |  if(Errors matches \"50011\", 1,0) as Errors_Count |  timeslice 1m | sum(Errors_Count) as Connection_Errors by _timeslice "
        query_type   = "Logs"
      }

      query {
        query_key    = "C"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   | json field=_raw \"Summary.Error.Code\" as Errors |  if(Errors matches \"12175\", 1,0) as Errors_Count | timeslice 1m | sum(Errors_Count) as SSL_Errors by _timeslice "
        query_type   = "Logs"
      }

      query {
        query_key    = "D"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   | json field=_raw \"Summary.Error.Code\" as Errors |  if(Errors matches \"50005\", 1,0) as Errors_Count | timeslice 1m | sum(Errors_Count) as Timeout_Errors by _timeslice"
        query_type   = "Logs"
      }

      query {
        query_key    = "E"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   | json field=_raw \"Summary.Error.Code\" as Errors |  if(Errors matches \"50112\", 1,0) as Errors_Count | timeslice 1m | sum(Errors_Count) as Transaction_Errors by _timeslice"
        query_type   = "Logs"
      }

      query {
        query_key    = "F"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   | json field=_raw \"Summary.Error.Code\" as Errors   |  if(Errors matches /^((?!((50010.*)|(50011.*)|(12175.*)|(50005.*)|(50112.*))).)*$/, 1,0) as Errors_Count | timeslice 1m |sum(Errors_Count) as Other_Errors by _timeslice"
        query_type   = "Logs"
      }

      title           = "Error Count"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Sequential 2\"},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelD2092B49AF97EA4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary.Error.Code\" as Errors\n| if(Errors matches \"12175\", 1,0) as SSL_errors\n| sum(SSL_errors) as SSL_errors\n"
        query_type   = "Logs"
      }

      title           = "# SSL Errors"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Average\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"No data\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":0,\"to\":1,\"color\":\"#8ecc1b\"},{\"from\":1,\"to\":25,\"color\":\"#DFBE2E\"},{\"from\":25,\"to\":100,\"color\":\"#ff5d5d\"}],\"sparkline\":{\"show\":false},\"gauge\":{\"show\":false,\"min\":0,\"max\":100}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-1694AD549570694E"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary\",\"Summary.Error.Code\",\"TestDetail.Name\",\"TestId\",\"Summary.Timing.Total\" as Test_Runs,Errors,Test_Name,Test_Id,Test_Time nodrop\n| if(Errors matches /\\d*/,1,0) as Error_count | if(!isNull(Test_Runs),1,0) as Test_Runs\n| avg(Test_Time) as Test_Time, sum(Error_count) as Error_count, sum(Test_Runs) as Test_Runs by Test_Name,Test_Id\n| (Error_count/Test_Runs)*100 as Percent_Downtime | round (Percent_Downtime, 2) as Percent_Downtime\n| round (Test_Time,2) as Test_Time \n| now() as Start_Timestamp\n| Start_Timestamp - 3600000 as End_Timestamp\n| tolong(Start_Timestamp) as Start_Timestamp\n| tolong(End_Timestamp) as End_Timestamp\n| formatDate(End_Timestamp, \"MMddYYYYHHmm\",\"America/New_York\") as Start_Date\n| formatDate(Start_Timestamp, \"MMddYYYYHHmm\",\"America/New_York\") as End_Date\n| concat (\"https://portal.catchpoint.com/ui/Preview/Smartboard/Syn/?cs=1\u0026testId=\",Test_Id,\"\u0026time=\",Start_Date,\"_\",End_Date,\"_7_0_999\") as TestUrl\n| tourl (TestUrl,Test_Name) as Test_Name \n| compare with timeshift 3h \n| fields  Test_Name,Test_Time,Test_Time_3h,Percent_Downtime,Percent_Downtime_3h\n| sort by Percent_Downtime\n| limit 20"
        query_type   = "Logs"
      }

      title           = "Tests Health"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-5FC90D03966B8943"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| _sourcehost as ip_address\n| json field=_raw \"Summary.Error.Code\" as Errors\n| if(Errors matches /\\d*/,1,0) as Error_Count\n| count  ip_address\n| lookup latitude, longitude, country_code, country_name, region, city, postal_code from geo://location on ip = ip_address"
        query_type   = "Logs"
      }

      title           = "Error by Node"
      visual_settings = "{\"general\":{\"mode\":\"map\",\"type\":\"map\",\"displayType\":\"default\"},\"title\":{\"fontSize\":14},\"series\":{},\"map\":{\"layerType\":\"Cluster\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-88755EF8BAF9C94C"


      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary.Timing.{{MetricNames}}\",\"NodeName\",\"TestId\",\"TestDetail.Name\" as {{MetricNames}},Node_Name,Test_Id,Test_Name\n| timeslice 1m\n| where Test_Name matches /^{{TestName}}$/ and Node_name matches /^{{NodeName}}$/\n| avg ({{MetricNames}}) as {{MetricNames}}  by Node_Name,Test_Id,_timeslice\n| transpose row _timeslice column  Node_Name,Test_Id "
        query_type   = "Logs"
      }

      title           = "Request Components"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
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

  title = "Catchpoint - Overview"

  variable {
    allow_multi_select = "false"
    default_value      = ".*"
    display_name       = "NodeName"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "NodeName"

    source_definition {
      log_query_variable_source_definition {
        field = "NodeName"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   and _collector=HTTP   |  json \"NodeName\" as NodeName\n"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = ".*"
    display_name       = "TestName"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "TestName"

    source_definition {
      log_query_variable_source_definition {
        field = "TestName"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   |json field=_raw \"TestDetail.Name\" as TestName"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "Connect"
    display_name       = "MetricNames"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "MetricNames"

    source_definition {
      csv_variable_source_definition {
        values = "Connect,Dns,ContentLoad,Load,Send,Ssl,Wait,Wire,Client"
      }
    }
  }
}

resource "sumologic_dashboard" "catchpoint_recent_errors" {
  description = "The Errors page lists all the errors encountered by synthetic tests. This page makes it easy to view the top issues as well as narrow down on problems to identify commonality between failures for any given test or group of tests."
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
        key       = "panelC440ADF488B5C84A"
        structure = "{\"height\":24,\"width\":24,\"x\":0,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelC440ADF488B5C84A"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary\",\"Summary.Error.Code\",\"Summary.Timing.Total\",\"NodeName\",\"TestDetail.Name\",\"TestId\" as Test_runs,Error_Code,Total,Node_Name,Test_Name,TestId nodrop\n| if(Error_Code matches \"50010\", \"DNS_Errors\",if(Error_Code matches \"50005\", \"Timeout_errors\",if(Error_Code matches \"12175\",\"SSL_Errors\",if(Error_Code matches \"50112\", \"Transaction_Errors\",if(Error_Code matches /^((?!((50010.*)|(50011.*)|(50005.*) | (50112.*)|(12175.*))).)*$/,\"Other_Errors\",\"No_Errors\"))))) as Error_Type\n| where Error_Type != \"No_Errors\" and Test_Name matches /^.*$/\n| timeslice 1m\n| avg(Total) as Test_Time by Test_Name,_timeslice,Error_Code,Error_Type,Node_Name,TestId\n| now() as Start_Timestamp\n| tolong(Start_Timestamp) as Start_Timestamp\n| formatDate(_timeslice, \"MMddYYYHHmm\",\"America/New_York\") as Start_Date\n| concat (\"https://portal.catchpoint.com/ui/Preview/Record/Synthetic?t=\",TestId,\"\u0026z=0\u0026n=11\u0026i=\",Start_Date,\"\u0026v=0\") as TestUrl\n| tourl (TestUrl,Error_Type) as Error_Type  \n| sort _timeslice \n| fields Test_Name,_timeslice,Error_Code,Error_Type,Node_Name,Test_Time"
        query_type   = "Logs"
      }

      title           = "Errors"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"table\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":11,\"labelFontSize\":10},\"axisY\":{\"title\":\"\",\"titleFontSize\":11,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{}}"
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

  title = "Catchpoint - Recent Errors"

  variable {
    allow_multi_select = "false"
    default_value      = ".*"
    display_name       = "TestName"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "TestName"

    source_definition {
      log_query_variable_source_definition {
        field = "TestName"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   | json field=_raw \"TestDetail.Name\" as TestName"
      }
    }
  }
}

resource "sumologic_dashboard" "catchpoint_response_size" {
  description = "The Response size dashboard plots the amount of data downloaded when loading each resource. This highlights the amount of content and the headers download size over time."
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
        key       = "panelD8EEBB53824DCB42"
        structure = "{\"height\":7,\"width\":12,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-0706BD74A396E94D"
        structure = "{\"height\":7,\"width\":24,\"x\":0,\"y\":14}"
      }

      layout_structure {
        key       = "panelPANE-83FB8E30B037B845"
        structure = "{\"height\":7,\"width\":12,\"x\":12,\"y\":1}"
      }

      layout_structure {
        key       = "panelPANE-EA27616E83E2E84C"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":8}"
      }

      layout_structure {
        key       = "panelPANE-F96F5F38943E6A43"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":7}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelD8EEBB53824DCB42"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary.Byte.Response.TotalContent\",\"NodeName\",\"TestId\",\"TestDetail.Name\" as TotalContent,Node_Name,Test_Id,Test_Name\n| where Test_Name matches /^{{TestName}}$/\n|  timeslice 1m \n| avg (TotalContent) as TotalContent  by Node_Name,Test_Id,_timeslice \n| TotalContent/1024/1024 as  TotalContent\n| transpose row _timeslice column  Node_Name,Test_Id"
        query_type   = "Logs"
      }

      title           = "Total Content (MB)"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Sequential 1\"},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-0706BD74A396E94D"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary.Byte.Response.ContentType.Css\",\"NodeName\",\"TestDetail.Name\" as Css,Node_Name,Test_Name\n| where Test_Name matches /^{{TestName}}$/ \n| avg (Css) as Css_in_bytes  by Test_Name,Node_Name\n| Css_in_bytes/1024/1024 as  Css_in_MB\n| round (Css_in_MB, 2) as Css_in_MB\n| sort by Css_in_MB\n| fields  Test_Name, Node_Name, Css_in_MB\n| limit 20"
        query_type   = "Logs"
      }

      title           = "Css"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-83FB8E30B037B845"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| json field=_raw \"Summary.Byte.Response.TotalHeaders\",\"NodeName\",\"TestId\",\"TestDetail.Name\" as TotalHeaders,Node_Name,Test_Id,Test_Name\n| timeslice 1m\n| where Test_Name matches /^{{TestName}}$/\n| avg (TotalHeaders) as TotalHeaders  by Node_Name,Test_Id,_timeslice\n| TotalHeaders/1024/1024 as  TotalHeaders \n| transpose row _timeslice column  Node_Name,Test_Id"
        query_type   = "Logs"
      }

      title           = "Total Headers (MB)"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Sequential 1\"},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-EA27616E83E2E84C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary.Byte.Response.ContentType.Script\",\"NodeName\",\"TestId\",\"TestDetail.Name\" as Script,Node_Name,Test_Id,Test_Name\n| timeslice 1m | where Test_Name matches /^{{TestName}}$/\n| avg (Script) as Script  by Node_Name,Test_Id,_timeslice\n| Script/1024/1024 as  Script\n| transpose row _timeslice column Node_Name,Test_Id"
        query_type   = "Logs"
      }

      title           = "Script (MB)"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Sequential 1\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-F96F5F38943E6A43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary.Byte.Response.ContentType.Html\",\"NodeName\",\"TestId\",\"TestDetail.Name\"  as Html,Node_Name,Test_Id,Test_Name\n| timeslice 1m\n| where Test_Name matches /^{{TestName}}$/\n| avg (Html) as Html  by Node_Name,Test_Id,_timeslice\n| Html/1024/1024 as  Html \n| transpose row _timeslice column  Node_Name,Test_Id"
        query_type   = "Logs"
      }

      title           = "HTML (MB)"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":null,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Sequential 1\"},\"series\":{},\"overrides\":[]}"
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

  title = "Catchpoint - Response Size"

  variable {
    allow_multi_select = "false"
    default_value      = ".*"
    display_name       = "TestName"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "TestName"

    source_definition {
      log_query_variable_source_definition {
        field = "TestName"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   and _collector=HTTP | json \"TestDetail.Name\"as TestName"
      }
    }
  }
}

resource "sumologic_dashboard" "catchpoint_test_times" {
  description = "The Test Time dashboard focuses on displaying how much time was spent loading resources. It plots the metrics over time making it easier to identify trends."
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
        key       = "panel40C7BE7497403944"
        structure = "{\"height\":7,\"width\":12,\"x\":0,\"y\":1}"
      }

      layout_structure {
        key       = "panel67F104A9BC9D7840"
        structure = "{\"height\":7,\"width\":12,\"x\":0,\"y\":8}"
      }

      layout_structure {
        key       = "panel67FAB5EBB17CFB46"
        structure = "{\"height\":7,\"width\":12,\"x\":12,\"y\":7}"
      }

      layout_structure {
        key       = "panelBF00DDBAB4B89B43"
        structure = "{\"height\":7,\"width\":12,\"x\":12,\"y\":14}"
      }

      layout_structure {
        key       = "panelE3213C839F13D84F"
        structure = "{\"height\":7,\"width\":12,\"x\":0,\"y\":15}"
      }

      layout_structure {
        key       = "panelPANE-7326F0CCA2B4F941"
        structure = "{\"height\":7,\"width\":12,\"x\":12,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel40C7BE7497403944"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary.Timing.DocumentComplete\",\"NodeName\",\"TestId\",\"TestDetail.Name\" as Document_Complete,Node_Name,Test_Id,Test_Name\n| where Test_Name matches /^{{TestName}}$/| timeslice 1m | avg (Document_Complete) as Document_Complete  by Node_Name,Test_Id,_timeslice\n| transpose row _timeslice column  Node_Name,Test_Id"
        query_type   = "Logs"
      }

      title           = "Document Complete (ms)"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Sequential 1\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel67F104A9BC9D7840"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary.Timing.DomLoad\",\"NodeName\",\"TestDetail.Name\",\"TestRuntime\" as DomLoad,Node_Name,Test_Id,Test_Name\n| where Test_Name matches /^{{TestName}}$/\n| timeslice 1m |  avg (DomLoad) as DomLoad  by Node_Name,Test_Id,_timeslice\n| transpose row _timeslice column Node_Name,Test_Id"
        query_type   = "Logs"
      }

      title           = "DOM Load (ms)"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Sequential 1\"},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel67FAB5EBB17CFB46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary.Timing.ContentLoad\",\"NodeName\",\"TestId\",\"TestDetail.Name\" as ContentLoad,Node_Name,Test_Id,Test_Name\n| where Test_Name matches /^{{TestName}}$/\n| timeslice 1m\n| avg (ContentLoad) as ContentLoad  by Node_Name,Test_Id,_timeslice\n| transpose row _timeslice column  Node_Name,Test_Id"
        query_type   = "Logs"
      }

      title           = "Content Load (ms)"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Sequential 1\"},\"overrides\":[],\"series\":{\"A_Bangalore, IN - Airtel|1560677\":{\"visible\":true},\"A_Bangalore, IN - Tata|1560677\":{\"visible\":false},\"A_Frankfurt, DE - AWS|1561476\":{\"visible\":false},\"A_Frankfurt, DE - Cogent|1560677\":{\"visible\":false},\"A_Frankfurt, DE - NTT|1560677\":{\"visible\":false},\"A_Frankfurt, DE - Level 3|1561476\":{\"visible\":false},\"A_Frankfurt, DE - Level 3|1560677\":{\"visible\":false},\"A_Frankfurt, DE - Cogent|1561476\":{\"visible\":false},\"A_New York, US - AT\u0026T|1561476\":{\"visible\":false},\"A_New York, US - Cogent|1560677\":{\"visible\":false},\"A_New York, US - Cogent|1561476\":{\"visible\":false},\"A_New York, US - Comcast|1560677\":{\"visible\":false},\"A_New York, US - Level3|1561476\":{\"visible\":false},\"A_New York, US - Level3|1560677\":{\"visible\":false}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelBF00DDBAB4B89B43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary.Timing.ContentType.Html\",\"NodeName\",\"TestDetail.Name\" as Html,Node_Name,Test_Name\n|  where Test_Name matches /^{{TestName}}$/\n| avg (Html) as Response_Time  by Test_Name,Node_Name\n| sort by Response_Time\n| limit 20"
        query_type   = "Logs"
      }

      title           = "HTML Load (ms)"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\",\"decimals\":2},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelE3213C839F13D84F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary.Timing.ContentType.Css\",\"NodeName\",\"TestDetail.Name\" as Css,Node_Name,Test_Name\n|  where Test_Name matches /^{{TestName}}$/\n| avg (Css) as Response_Time  by Test_Name,Node_Name\n| sort by Response_Time\n| limit 20"
        query_type   = "Logs"
      }

      title           = "Css Load (ms)"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"timeSeries\",\"decimals\":2},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-7326F0CCA2B4F941"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"Summary.Timing.Total\",\"NodeName\",\"TestId\",\"TestDetail.Name\" as Total,Node_Name,Test_Id,Test_Name\n| where Test_Name matches /^{{TestName}}$/\n| timeslice 1m\n| avg (Total) as Total  by _timeslice, Node_Name,Test_Id\n| transpose row _timeslice column  Node_Name,Test_Id"
        query_type   = "Logs"
      }

      title           = "Test Time (ms)"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Sequential 1\"},\"series\":{},\"overrides\":[]}"
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

  title = "Catchpoint - Test Times"

  variable {
    allow_multi_select = "false"
    default_value      = ".*"
    display_name       = "TestName"
    hide_from_ui       = "false"
    include_all_option = "false"
    name               = "TestName"

    source_definition {
      log_query_variable_source_definition {
        field = "TestName"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   and _collector=HTTP | json \"TestDetail.Name\"as TestName"
      }
    }
  }
}
