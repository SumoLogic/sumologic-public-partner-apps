resource "sumologic_dashboard" "amazon_ses_cloud_trail_evens_overeview" {
  description = "See an overview of SES CloudTrail events, including failed, and successful events, error codes, users, and event locations."
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



  layout {
    grid {
      layout_structure {
        key       = "panel1ee5a504901da94e"
        structure = "{\"height\":6,\"width\":6,\"x\":0,\"y\":15}"
      }

      layout_structure {
        key       = "panel282dcbf588eb3b49"
        structure = "{\"height\":8,\"width\":14,\"x\":10,\"y\":1}"
      }

      layout_structure {
        key       = "panel4ea01091ad4eca4b"
        structure = "{\"height\":6,\"width\":5,\"x\":0,\"y\":9}"
      }

      layout_structure {
        key       = "panel64e3e63f89021945"
        structure = "{\"height\":8,\"width\":9,\"x\":0,\"y\":21}"
      }

      layout_structure {
        key       = "panel9dcab67d9cc6b94d"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":9}"
      }

      layout_structure {
        key       = "panelPANE-D923721798BAF845"
        structure = "{\"height\":1,\"width\":18,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelc4cfc417ace76841"
        structure = "{\"height\":8,\"width\":15,\"x\":9,\"y\":15}"
      }

      layout_structure {
        key       = "paneld1ced73c9cb05841"
        structure = "{\"height\":6,\"width\":15,\"x\":9,\"y\":23}"
      }

      layout_structure {
        key       = "panelf17735658154c944"
        structure = "{\"height\":6,\"width\":7,\"x\":5,\"y\":9}"
      }

      layout_structure {
        key       = "panelfa13992fbe5c7b4a"
        structure = "{\"height\":8,\"width\":10,\"x\":0,\"y\":1}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel1ee5a504901da94e"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" errorCode\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventStatus=\"Failure\"\n| if (isEmpty(userName), user, userName) as user\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count as eventCount by eventName\n| sort by eventCount"
        query_type   = "Logs"
      }

      title           = "Failed Events"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":\"10\",\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel282dcbf588eb3b49"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   !\"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" errorCode\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventStatus=\"Failure\"\n| if (isEmpty(userName), user, userName) as user\n| timeslice 1s\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count as eventCount by _timeslice, eventName, errorCode, errorMessage, awsRegion, sourceIPAddress, accountId, user, type, requestID\n| sort by _timeslice"
        query_type   = "Logs"
      }

      title           = "Failed Event Details"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel4ea01091ad4eca4b"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count by eventStatus"
        query_type   = "Logs"
      }

      title           = "Event Statos"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":\"10\",\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel64e3e63f89021945"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" !errorCode\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventStatus=\"Success\"\n| if (isEmpty(userName), user, userName) as user\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count as eventCount by eventName\n| sort by eventCount"
        query_type   = "Logs"
      }

      title           = "Successful Events"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":\"10\",\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel9dcab67d9cc6b94d"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"zsdxcfgvbhjnkl\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| timeslice 1d\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count by _timeslice, eventStatus\n| fillmissing timeslice(1d), values (\"Success\", \"Failure\") in eventStatus\n| transpose row _timeslice column eventStatus"
        query_type   = "Logs"
      }

      time_range {
        begin_bounded_time_range {
          from {
            relative_time_range {
              relative_time = "-1w"
            }
          }
        }
      }

      title           = "Event Status Trend"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null},\"axisY2\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"minimum\":0,\"maximum\":null,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelc4cfc417ace76841"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| timeslice 1m\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count as eventCount by user,_timeslice\n| transpose row _timeslice column user"
        query_type   = "Logs"
      }

      title           = "Events by User"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"roundDataPoints\":true,\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "paneld1ced73c9cb05841"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count as eventCount by type, user\n| top 10 type, user by abc"
        query_type   = "Logs"
      }

      title           = "Top Users"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelf17735658154c944"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" errorCode\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventStatus=\"Failure\"\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n| count"
        query_type   = "Logs"
      }

      title           = "Eror Code Count"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true,\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"Errors\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelfa13992fbe5c7b4a"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   \"\\\"eventSource\\\":\\\"ses.amazonaws.com\\\"\" !errorCode\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop  \n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventStatus=\"Success\"\n| if (isEmpty(userName), user, userName) as user\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count by sourceIPAddress, eventName\n| lookup latitude, longitude, country_code, country_name, region, city, postal_code from geo://location on ip = sourceIPAddress\n| sort _count"
        query_type   = "Logs"
      }

      title           = "Sucesful Event Lokation"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-D923721798BAF845"
      text                                        = "This dshboard containing information about CloudTrail logs"
      visual_settings                             = "{\"general\":{\"mode\":\"TextPanel\",\"type\":\"text\",\"displayType\":\"default\",\"roundDataPoints\":true},\"title\":{\"fontSize\":14},\"series\":{},\"text\":{\"format\":\"markdownV2\",\"showTitle\":false},\"legend\":{\"enabled\":false}}"
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

  title = "Amazon SES - CloudTrail Evens Overeview"





  variable {
    allow_multi_select = "false"
    display_name       = "accountid"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "accountid"

    source_definition {
      log_query_variable_source_definition {
        field = "accountid"
        query = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| timeslice 1d"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "awsregion"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "awsregion"

    source_definition {
      log_query_variable_source_definition {
        field = "awsregion"
        query = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| timeslice 1d"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "errorcode"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "errorcode"

    source_definition {
      log_query_variable_source_definition {
        field = "errorcode"
        query = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| timeslice 1d"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "eventname"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "eventname"

    source_definition {
      log_query_variable_source_definition {
        field = "eventname"
        query = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| timeslice 1d"
      }
    }
  }
}

resource "sumologic_dashboard" "amazon_ses_complaint_notifications" {
  description = "See information about complaints (a complaint occurs when a recipient reports that they don't want to receive an email), including the top email addresses, email domains, and UserAgents associated with complaints; and the sending AccountId, AWS region, SourceIP, and Identity associated with complaints."
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



  layout {
    grid {
      layout_structure {
        key       = "panel1d28e45386478a40"
        structure = "{\"height\":1,\"width\":24,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panel230691659ced8848"
        structure = "{\"height\":6,\"width\":6,\"x\":0,\"y\":1}"
      }

      layout_structure {
        key       = "panel46f7d6c7872dea49"
        structure = "{\"height\":6,\"width\":6,\"x\":12,\"y\":1}"
      }

      layout_structure {
        key       = "panel5a1e59cb90d2b848"
        structure = "{\"height\":6,\"width\":6,\"x\":12,\"y\":7}"
      }

      layout_structure {
        key       = "panel9d7350fe8aa66a48"
        structure = "{\"height\":6,\"width\":6,\"x\":6,\"y\":1}"
      }

      layout_structure {
        key       = "panela0bcbaddaa39894b"
        structure = "{\"height\":8,\"width\":12,\"x\":0,\"y\":7}"
      }

      layout_structure {
        key       = "panelae789435b40e0b4d"
        structure = "{\"height\":5,\"width\":19,\"x\":2,\"y\":15}"
      }

      layout_structure {
        key       = "paneldd502e4a9688f940"
        structure = "{\"height\":9,\"width\":6,\"x\":18,\"y\":1}"
      }

      layout_structure {
        key       = "panelf8656e7b8f120943"
        structure = "{\"height\":5,\"width\":6,\"x\":18,\"y\":10}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel230691659ced8848"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop \n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\"\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" AND useragent matches \"{{useragent}}\" AND name matches \"{{name}}\" AND source matches \"{{source}}\" AND sourceip matches \"{{sourceip}}\"\n|count as eventCount by ComplaintemailAddress\n| sort by eventCount, ComplaintemailAddress\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Top Complaint email Addresses"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel46f7d6c7872dea49"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop \n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| if (isEmpty(complaintFeedbackType), \"InformationNotAvailable\", complaintFeedbackType) as complaintFeedbackType\n| where notificationType=\"Complaint\"\n| timeslice 15m\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" AND useragent matches \"{{useragent}}\" AND name matches \"{{name}}\" AND source matches \"{{source}}\" AND sourceip matches \"{{sourceip}}\"\n|count by _timeslice, complaintFeedbackType \n| transpose row _timeslice column complaintFeedbackType"
        query_type   = "Logs"
      }

      title           = "Complaint Feedback Type Trend"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"overrides\":[{\"series\":[\"abuse\"],\"queries\":[],\"properties\":{\"axisYType\":\"primary\",\"type\":\"column\"}}],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel5a1e59cb90d2b848"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Complaint\\\"\" userAgent\n| json \"notificationType\", \"mail\" nodrop \n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\" and !isEmpty(userAgent)\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" AND useragent matches \"{{useragent}}\" AND name matches \"{{name}}\" AND source matches \"{{source}}\" AND sourceip matches \"{{sourceip}}\"\n|count as eventCount by userAgent\n| sort by eventCount, userAgent asc\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Top Complaint UserAgents"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel9d7350fe8aa66a48"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop \n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\"\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" AND useragent matches \"{{useragent}}\" AND name matches \"{{name}}\" AND source matches \"{{source}}\" AND sourceip matches \"{{sourceip}}\"\n|count as eventCount by domain\n| sort by eventCount, domain asc\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Top Complaint email Domains"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panela0bcbaddaa39894b"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Complaint\\\"\" source\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| count by source,sourceArn, notificationType, sendingaccountid, awsregion, complaintemailaddress, complaintfeedbacktype, domain, eventCount\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\"\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" \n| top 10 source by eventCount, source asc"
        query_type   = "Logs"
      }

      title           = "Top Source Generating Complaints"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelae789435b40e0b4d"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\"\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" AND useragent matches \"{{useragent}}\" AND name matches \"{{name}}\" AND source matches \"{{source}}\" AND sourceip matches \"{{sourceip}}\"\n|count as eventCount by sendingAccountId"
        query_type   = "Logs"
      }

      title           = "Sending AccountId"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "paneldd502e4a9688f940"

      query {
        query_key    = "A"
        query_string = "_sourceCategory=$$logparams   \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\"\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" AND useragent matches \"{{useragent}}\" AND name matches \"{{name}}\" AND source matches \"{{source}}\" AND sourceip matches \"{{sourceip}}\"\n|count as eventCount by awsRegion\n| sort by eventCount, awsRegion asc"
        query_type   = "Logs"
      }

      title           = "Sending AWS Region"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelf8656e7b8f120943"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}   \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" errorCode\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventStatus=\"Failure\"\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n| count"
        query_type   = "Logs"
      }

      title           = "Eror Code Count"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true,\"mode\":\"singleValueMetrics\"},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"Errors\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel1d28e45386478a40"
      title                                       = "Complaint Recipients"
      visual_settings                             = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"text\",\"displayType\":\"default\",\"mode\":\"TextPanel\"},\"legend\":{\"enabled\":false},\"text\":{\"format\":\"markdownV2\",\"fontSize\":14},\"series\":{}}"
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

  title = "Amazon SES - Complaint Notifications"





  variable {
    allow_multi_select = "false"
    display_name       = "awsregion"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "awsregion"

    source_definition {
      log_query_variable_source_definition {
        field = "awsregion"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "complaintemailaddress"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "complaintemailaddress"

    source_definition {
      log_query_variable_source_definition {
        field = "complaintemailaddress"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "complaintfeedbacktype"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "complaintfeedbacktype"

    source_definition {
      log_query_variable_source_definition {
        field = "complaintfeedbacktype"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "domain"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "domain"

    source_definition {
      log_query_variable_source_definition {
        field = "domain"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "name"

    source_definition {
      log_query_variable_source_definition {
        field = "name"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "sendingaccountid"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "sendingaccountid"

    source_definition {
      log_query_variable_source_definition {
        field = "sendingaccountid"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "source"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "source"

    source_definition {
      log_query_variable_source_definition {
        field = "source"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "sourceip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "sourceip"

    source_definition {
      log_query_variable_source_definition {
        field = "sourceip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "useragent"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "useragent"

    source_definition {
      log_query_variable_source_definition {
        field = "useragent"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
      }
    }
  }
}

resource "sumologic_dashboard" "amazon_ses_notification_overview" {
  description = "See an overview of SES notifications including the source IP locations, notification types, mail source, and accountId."
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



  layout {
    grid {
      layout_structure {
        key       = "panel262ce8bc80918842"
        structure = "{\"width\":6,\"height\":5,\"x\":18,\"y\":0}"
      }

      layout_structure {
        key       = "panel4760897ea3c55840"
        structure = "{\"width\":12,\"height\":14,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panel6ee76c9299bfb946"
        structure = "{\"width\":6,\"height\":9,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panel94311a6e8f03c944"
        structure = "{\"width\":6,\"height\":4,\"x\":18,\"y\":4}"
      }

      layout_structure {
        key       = "panelc44f1e409455ea4f"
        structure = "{\"width\":12,\"height\":5,\"x\":12,\"y\":7}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel262ce8bc80918842"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   mail source\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop\n|where mailsourceip matches \"{{mailsourceip}}\" AND mailsendingaccountid matches \"{{mailsendingaccountid}}\" AND mailsource matches \"{{mailsource}}\" AND notificationtype matches \"{{notificationtype}}\"\n|count as eventCount by mailSource | where !isBlank(mailSource)\n| sort by eventCount, mailSource\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Mail Source"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel4760897ea3c55840"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   mail sourceIp\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop\n|where mailsourceip matches \"{{mailsourceip}}\" AND mailsendingaccountid matches \"{{mailsendingaccountid}}\" AND mailsource matches \"{{mailsource}}\" AND notificationtype matches \"{{notificationtype}}\"\n|count as eventCount by mailSourceIP\n| where !isBlank(mailSourceIP)\n| lookup latitude, longitude, country_name, region, city from geo://location on ip=mailSourceIP\n| count by latitude, longitude, country_name, region, city"
        query_type   = "Logs"
      }

      title           = "Mail Source IP Locations"
      visual_settings = "{\"general\":{\"mode\":\"map\",\"type\":\"map\"},\"map\":{\"mainMetric\":{}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel6ee76c9299bfb946"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   notificationType\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop\n|where mailsourceip matches \"{{mailsourceip}}\" AND mailsendingaccountid matches \"{{mailsendingaccountid}}\" AND mailsource matches \"{{mailsource}}\" AND notificationtype matches \"{{notificationtype}}\"\n|count as eventCount by notificationType | where !isBlank(notificationType)\n| sort by eventCount"
        query_type   = "Logs"
      }

      title           = "Notification Types"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":\"10\",\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel94311a6e8f03c944"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   mail sendingAccountId\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop\n|where mailsourceip matches \"{{mailsourceip}}\" AND mailsendingaccountid matches \"{{mailsendingaccountid}}\" AND mailsource matches \"{{mailsource}}\" AND notificationtype matches \"{{notificationtype}}\"\n|count as eventCount by mailSendingAccountId | where !isBlank(mailSendingAccountId)\n| sort by eventCount, mailSendingAccountId\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Mail Sending AccountId"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelc44f1e409455ea4f"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   notificationType\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop\n| where !isBlank(notificationType)\n| timeslice 15m\n|where mailsourceip matches \"{{mailsourceip}}\" AND mailsendingaccountid matches \"{{mailsendingaccountid}}\" AND mailsource matches \"{{mailsource}}\" AND notificationtype matches \"{{notificationtype}}\"\n|count by _timeslice, NotificationType\n| transpose row _timeslice column NotificationType"
        query_type   = "Logs"
      }

      title           = "Notification Type Trend"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":null,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"overrides\":[],\"series\":{}}"
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

  title = "Amazon SES - Notification Overview"





  variable {
    allow_multi_select = "false"
    display_name       = "mailsendingaccountid"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "mailsendingaccountid"

    source_definition {
      log_query_variable_source_definition {
        field = "mailsendingaccountid"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   mail source\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "mailsource"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "mailsource"

    source_definition {
      log_query_variable_source_definition {
        field = "mailsource"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   mail source\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "mailsourceip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "mailsourceip"

    source_definition {
      log_query_variable_source_definition {
        field = "mailsourceip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   mail source\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "notificationtype"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "notificationtype"

    source_definition {
      log_query_variable_source_definition {
        field = "notificationtype"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   mail source\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop"
      }
    }
  }
}
