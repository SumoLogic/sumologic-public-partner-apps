resource "sumologic_dashboard" "circle_ci_overview" {
  description = "View your CircleCI pipeline data in real time or tracked over time."
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
        key       = "panel123CF5F097CBCB48"
        structure = "{\"height\":6,\"width\":7,\"x\":15,\"y\":6}"
      }

      layout_structure {
        key       = "panel2935204D85845B41"
        structure = "{\"height\":5,\"width\":15,\"x\":0,\"y\":14}"
      }

      layout_structure {
        key       = "panel608608139ED6F940"
        structure = "{\"height\":6,\"width\":8,\"x\":0,\"y\":8}"
      }

      layout_structure {
        key       = "panel635D794D9F73E847"
        structure = "{\"height\":4,\"width\":8,\"x\":0,\"y\":4}"
      }

      layout_structure {
        key       = "panel6D890EC888A86A46"
        structure = "{\"height\":4,\"width\":7,\"x\":8,\"y\":4}"
      }

      layout_structure {
        key       = "panel771A3CFEA6355B40"
        structure = "{\"height\":6,\"width\":7,\"x\":15,\"y\":0}"
      }

      layout_structure {
        key       = "panel79344C27B8D4894B"
        structure = "{\"height\":7,\"width\":7,\"x\":15,\"y\":12}"
      }

      layout_structure {
        key       = "panel89F2509FBDCA2B44"
        structure = "{\"height\":4,\"width\":3,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panel92F20EFCA3453A47"
        structure = "{\"height\":4,\"width\":7,\"x\":8,\"y\":0}"
      }

      layout_structure {
        key       = "panelDDF457C8B725CA4F"
        structure = "{\"height\":4,\"width\":5,\"x\":3,\"y\":0}"
      }

      layout_structure {
        key       = "panelFC518250B2C32947"
        structure = "{\"height\":6,\"width\":7,\"x\":8,\"y\":8}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel123CF5F097CBCB48"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Manual"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| json \"type\", \"project.name\", \"workflow.name\", \"workflow.created_at\", \"workflow.stopped_at\" as type, project, workflow, created, stopped \n| where project matches \"{{project}}\"\n| where %type = \"workflow-completed\" \n| parseDate(stopped, \"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'\") as d1 \n| parseDate(created, \"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'\") as d2 \n| (d1 - d2) / 1000 / 60 as minutes\n| avg(minutes) as minutes by workflow, project | round(minutes, 2) as minutes | format(\"%.2f\", minutes) as minutes | sort by minutes |limit 5"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Top 10 Longest Workflows (Averaged)"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel2935204D85845B41"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Manual"
        query_key                = "A"
        query_string             = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"type\" | where %type = \"job-completed\"\n| json \"job.started_at\", \"job.stopped_at\" as start, end\n| parseDate(start, \"yyyy-MM-dd'T'HH:mm:ss.SSSXXX\") as start\n| parseDate(end, \"yyyy-MM-dd'T'HH:mm:ss.SSSXXX\") as end\n| round((end - start) / 1000) as duration_sec\n| json \"project.name\" as project\n| where project matches \"{{project}}\"\n| json \"job.name\" as job \n| where job matches \"{{job}}\"\n| timeslice 1d\n| avg(duration_sec) as duration_sec by job, project, _timeslice | round(duration_sec)\n| transpose row _timeslice column job, project"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Average Job Runtime Per Day"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"smooth\"},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel608608139ED6F940"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Manual"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| json \"project.name\", \"job.name\", \"job.status\", \"job.number\", \"happened_at\" as project, job, status, number, at\n| where project matches \"{{project}}\"\n| where status = \"failed\"\n| \"❌\" as status\n| count(at) as when by project, job, status, number, at\n| sort by at\n| parseDate(at, \"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'\") as at\n| formatDate(at, \"yy-MM-dd HH:mm\") as at\n| fields project, job, status, number, at\n| limit 5"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "5 Most Recent Failed Jobs"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel635D794D9F73E847"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Manual"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"job.status\" as status\n| json field=_raw \"project.name\" as projectName| where projectName matches \"{{project}}\"\n| withtime status\n| timeslice 1d\n| count by _timeslice, status\n| transpose row _timeslice column status"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      time_range {
        begin_bounded_time_range {
          from {
            relative_time_range {
              relative_time = "-2w"
            }
          }
        }
      }

      title           = "Daily Performance"
      visual_settings = "{\"series\":{},\"overrides\":[{\"series\":[\"failed\"],\"queries\":[],\"properties\":{\"color\":\"#bf2121\"}},{\"series\":[\"success\"],\"queries\":[],\"properties\":{\"color\":\"#98eca9\"}}],\"general\":{\"type\":\"line\",\"displayType\":\"smooth\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":2,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel6D890EC888A86A46"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Manual"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"type\" as type\n| where type = \"job-completed\"\n| json \"job.id\", \"project.name\" as jobID, project\n| withtime jobID\n| timeslice 1d\n| count by _timeslice, project\n| transpose row _timeslice column project"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      time_range {
        begin_bounded_time_range {
          from {
            relative_time_range {
              relative_time = "-2w"
            }
          }
        }
      }

      title           = "Jobs per day"
      visual_settings = "{\"series\":{},\"general\":{\"type\":\"line\",\"displayType\":\"smooth\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":2,\"mode\":\"timeSeries\"},\"color\":{\"family\":\"Categorical Default\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel771A3CFEA6355B40"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Manual"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| json \"project.name\", \"job.name\", \"job.status\" as project, job, status\n| where project matches \"{{project}}\"\n| count as jobs by project"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Jobs Ran Per Project"
      visual_settings = "{\"series\":{},\"general\":{\"type\":\"bar\",\"displayType\":\"default\",\"fillOpacity\":1,\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel79344C27B8D4894B"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Manual"
        query_key                = "A"
        query_string             = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json \"type\"\n| where %type = \"job-completed\"\n| json \"job.started_at\", \"job.stopped_at\" as start, end\n| parseDate(start, \"yyyy-MM-dd'T'HH:mm:ss.SSSXXX\") as start\n| parseDate(end, \"yyyy-MM-dd'T'HH:mm:ss.SSSXXX\") as end\n| round((end - start) / 1000) as duration_sec\n| json field=_raw \"project.name\" as project\n| where project matches \"{{project}}\"\n| json field=_raw \"job.name\" as job\n| avg(duration_sec) as Avg_Duration_Seconds by project, job\n| round(Avg_Duration_Seconds)\n| sort by Avg_Duration_Seconds\n| limit 10"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Top 10 longest running jobs"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel89F2509FBDCA2B44"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Manual"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| json \"project.name\" as project\n| where project matches \"{{project}}\"\n| json \"job.number\"\n| count"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Total Jobs"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\"},\"series\":{},\"svp\":{\"label\":\"Jobs Ran\",\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}]}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel92F20EFCA3453A47"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Manual"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json field=_raw \"job.status\" as result\n| json field=_raw \"project.name\" as project\n| where project matches \"*\"\n| count as jobs by project, result\n| transpose row project column result as failed, success\n| if(isNull(failed), 0, failed) as failed\n| if(isNull(success), 0, success) as success\n| format(\"%.1f %s\",(success/(success + failed))*100, \"%\") as health"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Summary"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelDDF457C8B725CA4F"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Manual"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json \"project.name\", \"job.status\" as projectName, outcome\n| where projectName matches \"{{project}}\"\n| count as jobs by outcome"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Job Health"
      visual_settings = "{\"series\":{},\"overrides\":[{\"series\":[\"failed\"],\"queries\":[],\"properties\":{\"color\":\"#bf2121\"}},{\"series\":[\"success\"],\"queries\":[],\"properties\":{\"color\":\"#98eca9\"}}],\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelFC518250B2C32947"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Manual"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| json \"project.name\", \"workflow.name\", \"workflow.status\", \"happened_at\" as project, workflow, status, at\n| where project matches \"{{project}}\"\n| where status=\"failed\"\n| \"❌\" as status\n| count(at) as when by project, workflow, status, at\n| sort by at\n| parseDate(at, \"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'\") as at\n| formatDate(at, \"yy-MM-dd HH:mm\") as at\n| fields project, workflow, status, at\n| limit 5 "
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "5 Most Recent Failed Workflows"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  refresh_interval = "0"
  theme            = "Light"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-15m"
        }
      }
    }
  }

  title = "CircleCI - Overview"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "job"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "job"

    source_definition {
      log_query_variable_source_definition {
        field = "job"
        query = "(${var.scope_key}={{${var.scope_key_variable_display_name}}}  )\n| json field=_raw \"type\" | where %type = \"job-completed\"\n| json field=_raw \"job.name\" as job"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "project"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "project"

    source_definition {
      log_query_variable_source_definition {
        field = "project"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   | json field=_raw \"project.name\" as project"
      }
    }
  }
}
