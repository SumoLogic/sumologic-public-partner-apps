resource "sumologic_dashboard" "cybereason_defense_platform" {
  description = "The Dashboard provides an Out Of The Box security overview, enabling Security Operation teams to rapidly detect and end Cyber attacks."
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
        key       = "panel62C454E58D8CDA49"
        structure = "{\"height\":10,\"width\":24,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panelPANE-43DF162597759B4B"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panelPANE-936A6D43AAFDFB45"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-A6F927B59D290A42"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-A9D2F49FB42C6845"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":6}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel62C454E58D8CDA49"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| json auto\n| formatDate(toLong(lastUpdateTime), \"yyyy-MM-dd:HH-MM\") as %\"Last Update Date\"\n| %machines[0].displayname as %\"Affected Machine\"\n| displayname as %\"Malop Name\"\n| malopdetectiontype as %\"Detection Type\"\n| rootcauseelementtype as %\"Root Cause Element\"\n| status as %\"Status\"\n| count by _raw, %\"Malop Name\" ,%\"Last Update Date\" , %\"Affected Machine\", %\"Detection Type\", %\"Root Cause Element\",%\"Status\"\n| fields -_count,_raw"
        query_type   = "Logs"
      }

      title           = "MALOP INBOX"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-43DF162597759B4B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| json \"machines\" \n| parse regex field=machines \"\\\"displayName\\\":\\\"(?<displayname>.*?)\\\"\" multi\n| count by displayname | sort by _count desc "
        query_type   = "Logs"
      }

      title           = "MOST TARGETED HOSTS"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"color\":{\"family\":\"Sequential 1\"},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-936A6D43AAFDFB45"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| json \"creationTime\" as tmp\n| tolong(tmp) as _messagetime\n| timeslice 1d \n| count by _timeslice"
        query_type   = "Logs"
      }

      title           = "MALOP TREND BY TIME"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":5,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":11,\"labelFontSize\":10},\"axisY\":{\"title\":\"Number Of Malops\",\"titleFontSize\":11,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{\"A__count\":{\"visible\":true}},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-A6F927B59D290A42"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}    \n| formatDate(toLong(creationTime), \"yyyy-MM-dd\") as CreationTime \n| formatDate(toLong(lastupdatetime), \"yyyy-MM-dd\") as LastUpdateTime \n| count by status"
        query_type   = "Logs"
      }

      title           = "MALOP STATUSES"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"color\":{\"family\":\"Sequential 1\"},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-A9D2F49FB42C6845"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| formatDate(toLong(creationTime), \"yyyy-MM-dd\") as CreationTime \n| formatDate(toLong(lastupdatetime), \"yyyy-MM-dd\") as LastUpdateTime \n| count by malopdetectiontype"
        query_type   = "Logs"
      }

      title           = "DETECTED MALICIOUS ACTIVITY "
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":5},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"color\":{\"family\":\"Sequential 1\"},\"legend\":{\"enabled\":false}}"
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

  title = "Cybereason Defense Platform"
}
