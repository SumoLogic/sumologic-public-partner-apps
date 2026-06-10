resource "sumologic_dashboard" "auth___overview" {
  description = "The Auth0 - Overview dashboard provides insights into authentication activity, tracking login geo locations on a world map and visualizing login attempts per hour over the last seven days. It highlights the top users by successful and failed logins, as well as the most frequent source IPs for failed logins, helping to identify potential security threats."
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
        key       = "panel19F1404CB3B04943"
        structure = "{\"height\":10,\"width\":12,\"x\":12,\"y\":52}"
      }

      layout_structure {
        key       = "panel31EC144E863B1B45"
        structure = "{\"height\":8,\"width\":16,\"x\":8,\"y\":15}"
      }

      layout_structure {
        key       = "panel3639A8199438E6D9"
        structure = "{\"height\":10,\"width\":12,\"x\":0,\"y\":42}"
      }

      layout_structure {
        key       = "panel549F0526A4668B48"
        structure = "{\"height\":10,\"width\":24,\"x\":0,\"y\":72,\"minHeight\":3,\"minWidth\":3}"
      }

      layout_structure {
        key       = "panel661E2437B6B6E842"
        structure = "{\"height\":9,\"width\":16,\"x\":8,\"y\":23}"
      }

      layout_structure {
        key       = "panel66B35A60EA090A86"
        structure = "{\"height\":8,\"width\":16,\"x\":8,\"y\":7}"
      }

      layout_structure {
        key       = "panel74DD1438756B74AD"
        structure = "{\"height\":8,\"width\":8,\"x\":0,\"y\":7}"
      }

      layout_structure {
        key       = "panel7634C61E9B573B4A"
        structure = "{\"height\":7,\"width\":8,\"x\":16,\"y\":0}"
      }

      layout_structure {
        key       = "panel78DFF99EF6F1C5A0"
        structure = "{\"height\":10,\"width\":12,\"x\":0,\"y\":52}"
      }

      layout_structure {
        key       = "panel79C7887C637A1C85"
        structure = "{\"height\":9,\"width\":8,\"x\":0,\"y\":23}"
      }

      layout_structure {
        key       = "panel8B5A2F30A944FA4B"
        structure = "{\"height\":10,\"width\":8,\"x\":0,\"y\":32}"
      }

      layout_structure {
        key       = "panelA265C19759357085"
        structure = "{\"height\":10,\"width\":12,\"x\":12,\"y\":42}"
      }

      layout_structure {
        key       = "panelA2A3D19EB4B4E84A"
        structure = "{\"height\":10,\"width\":8,\"x\":16,\"y\":32}"
      }

      layout_structure {
        key       = "panelB7F84B5506FB1C5B"
        structure = "{\"height\":8,\"width\":8,\"x\":0,\"y\":15}"
      }

      layout_structure {
        key       = "panelD901ED0F8DF05B40"
        structure = "{\"height\":10,\"width\":8,\"x\":8,\"y\":32}"
      }

      layout_structure {
        key       = "panelDAE9FB8D3578606A"
        structure = "{\"height\":10,\"width\":24,\"x\":0,\"y\":62}"
      }

      layout_structure {
        key       = "panelDC9DA9F6A16A3944"
        structure = "{\"height\":7,\"width\":8,\"x\":8,\"y\":0}"
      }

      layout_structure {
        key       = "panelPANE-5A486DE48B5B0943"
        structure = "{\"height\":7,\"width\":8,\"x\":0,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel19F1404CB3B04943"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  (\"fp\" OR \"fu\") log_id ip\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| where !isBlank(ip) and type in (\"fp\", \"fu\")\n| count by log_id, ip\n| count by ip\n| lookup latitude, longitude from geo://location on ip = ip\n| where !isNull(latitude)"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Geo Location of Failed Events"
      visual_settings = "{\"general\":{\"mode\":\"map\",\"type\":\"map\"},\"map\":{\"type\":\"geo\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel31EC144E863B1B45"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id connection\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| where !isBlank(connection)\n| timeslice 1h\n| count by log_id, _timeslice, connection\n| count by _timeslice, connection\n| fillmissing timeslice, values all in connection\n| transpose row _timeslice column connection"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Connection Over Time"
      visual_settings = "{\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel3639A8199438E6D9"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id client_name\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| where !isBlank(client_name)\n| count by log_id, client_name\n| count by client_name\n| sort by _count, client_name asc\n| limit 10"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Top 10 Client Name"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"bar\"},\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel549F0526A4668B48"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id client_name\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\", \"details.error.message\", \"strategy_type\" as type, user_name, client_name, connection, ip, error_message, strategy_type nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| where type in (\"fp\", \"fu\")\n| formatDate(toLong(_messageTime), \"MM/dd/yyyy HH:mm:ss\") as time\n| count by log_id, time, type, user_name, client_name, connection, ip, strategy_type, error_message\n| count by time, type, user_name, client_name, connection, ip, strategy_type, error_message\n| sort by time, type asc, user_name asc\n| fields - _count\n| limit 500"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Failed Events Summary"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\",\"paginationPageSize\":10},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel661E2437B6B6E842"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| where !isBlank(client_name)\n| timeslice 1h\n| count by log_id, _timeslice, client_name\n| count by _timeslice, client_name\n| fillmissing timeslice, values all in client_name\n| transpose row _timeslice column client_name"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Events Over Time by Client"
      visual_settings = "{\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel66B35A60EA090A86"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id type\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| where !isBlank(type)\n| timeslice 1h\n| count by log_id, _timeslice, type\n| count by _timeslice, type\n| fillmissing timeslice, values all in type\n| transpose row _timeslice column type"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Event Types Over Time"
      visual_settings = "{\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel74DD1438756B74AD"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id type\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| where !isBlank(type)\n| count by log_id, type\n| count by type\n| sort by _count, type asc"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Events by Type"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"innerRadius\":\"30%\"},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel7634C61E9B573B4A"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id strategy_type\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\", \"strategy_type\" as type, user_name, client_name, connection, ip, strategy_type nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| where !isBlank(strategy_type)\n| count by log_id, strategy_type\n| count by strategy_type\n| sort by _count, strategy_type asc"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Events by Strategy Type"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"innerRadius\":\"30%\"},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel78DFF99EF6F1C5A0"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id ip\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| where !isBlank(ip)\n| count by log_id, ip\n| count by ip\n| lookup latitude, longitude from geo://location on ip = ip\n| where !isNull(latitude)"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Geo Location of Events"
      visual_settings = "{\"general\":{\"mode\":\"map\",\"type\":\"map\"},\"map\":{\"type\":\"geo\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel79C7887C637A1C85"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id user_name\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| where type = \"s\" and !isBlank(user_name)\n| count by log_id, user_name \n| count as count by user_name \n| sort by count, user_name asc\n| limit 10"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Top 10 Users by Successful Login"
      visual_settings = "{\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8B5A2F30A944FA4B"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id type user_name (\"fp\" OR \"fu\")\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| where type in (\"fp\", \"fu\") and !isBlank(user_name)\n| count by log_id, user_name \n| count as count by user_name \n| sort by count, user_name asc\n| limit 10"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Top 10 Users by Failed Login"
      visual_settings = "{\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelA265C19759357085"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id type\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| where !isBlank(type)\n| count by log_id, type\n| count as count by type\n| sort by count, type asc\n| compare with timeshift 1d"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Events - One Day Time Comparison"
      visual_settings = "{\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelA2A3D19EB4B4E84A"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  (\"fp\" OR \"fu\") type error message\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\", \"details.error.message\" as type, user_name, client_name, connection, ip, error_message nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| where type in (\"fp\", \"fu\") and !isBlank(error_message)\n| count by log_id, error_message \n| count as count by error_message \n| sort by count, error_message asc"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Top Failed Login Failures Reason"
      visual_settings = "{\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB7F84B5506FB1C5B"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id connection\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| where !isBlank(connection)\n| count by log_id, connection\n| count by connection\n| sort by _count, connection asc"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Events by Connection"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"innerRadius\":\"30%\"},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelD901ED0F8DF05B40"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id ip type (\"fp\" OR \"fu\")\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| where type in (\"fp\", \"fu\") and !isBlank(ip)\n| count by log_id, ip \n| count as count by ip \n| sort by count, ip asc\n| limit 10"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Top 10 Source IPs by Failed Login"
      visual_settings = "{\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelDAE9FB8D3578606A"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id client_name\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\", \"hostname\" as type, user_name, client_name, connection, ip, host_name nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| formatDate(toLong(_messageTime), \"MM/dd/yyyy HH:mm:ss\") as time\n| count by log_id, time, type, user_name, client_name, connection, ip, host_name\n| count by time, type, user_name, client_name, connection, ip, host_name\n| sort by time, type asc, user_name asc\n| fields - _count\n| limit 500"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Recent Events Summary"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\",\"paginationPageSize\":10},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelDC9DA9F6A16A3944"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| count by user_name\n| count"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Total Users"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true,\"noDataMessage\":\"0\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-5A486DE48B5B0943"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and user_name matches \"{{user_name}}\" and client_name matches \"{{client_name}}\" and connection matches \"{{connection}}\" and ip matches \"{{ip}}\" \n\n// panel specific\n| count by log_id\n| count"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Total Events"
      visual_settings = "{\"general\":{\"mode\":\"singleValueMetrics\",\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true,\"noDataMessage\":\"0\"},\"title\":{\"fontSize\":14},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{},\"legend\":{\"enabled\":false}}"
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

  title = "Auth0 - Overview"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "client_name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "client_name"

    source_definition {
      log_query_variable_source_definition {
        field = "client_name"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  client_name\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"client_name\" as client_name\n| where !isBlank(client_name)\n| count by client_name\n| sort by client_name asc"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "connection"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "connection"

    source_definition {
      log_query_variable_source_definition {
        field = "connection"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  connection\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"connection\" as connection\n| where !isBlank(connection)\n| count by connection\n| sort by connection asc"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "ip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "ip"

    source_definition {
      log_query_variable_source_definition {
        field = "ip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  ip\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"ip\" as ip\n| where !isBlank(ip)\n| count by ip\n| sort by ip asc"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "type"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "type"

    source_definition {
      log_query_variable_source_definition {
        field = "type"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  type\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\" as type\n| count by type\n| sort by type asc"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "user_name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "user_name"

    source_definition {
      log_query_variable_source_definition {
        field = "user_name"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  user_name\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"user_name\" as user_name\n| where !isBlank(user_name)\n| count by user_name\n| sort by user_name asc"
      }
    }
  }
}

resource "sumologic_dashboard" "auth___security_analysis" {
  description = "The Auth0 - Security Analysis dashboard delivers security focused analysis of Auth0 authentication events including risk assessments, new device detection, impossible travel indicators, and login performance for identifying compromised accounts and suspicious access patterns."
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
        key       = "panel2D69927694C3B566"
        structure = "{\"height\":10,\"width\":12,\"x\":12,\"y\":25}"
      }

      layout_structure {
        key       = "panel668C42F29B787B4B"
        structure = "{\"height\":9,\"width\":12,\"x\":12,\"y\":16}"
      }

      layout_structure {
        key       = "panel7CA343C9C7543BB6"
        structure = "{\"height\":8,\"width\":8,\"x\":0,\"y\":8}"
      }

      layout_structure {
        key       = "panel7ED4B79894CB4B48"
        structure = "{\"height\":9,\"width\":12,\"x\":0,\"y\":16}"
      }

      layout_structure {
        key       = "panel88992B96AEADDA49"
        structure = "{\"height\":8,\"width\":8,\"x\":16,\"y\":8}"
      }

      layout_structure {
        key       = "panel8C96833AB3CB2842"
        structure = "{\"height\":10,\"width\":12,\"x\":0,\"y\":25}"
      }

      layout_structure {
        key       = "panel93DEF7CF2688984D"
        structure = "{\"height\":10,\"width\":16,\"x\":0,\"y\":35}"
      }

      layout_structure {
        key       = "panelA594B74F75FAE89E"
        structure = "{\"height\":10,\"width\":8,\"x\":16,\"y\":35}"
      }

      layout_structure {
        key       = "panelB6126C06ED007427"
        structure = "{\"height\":8,\"width\":8,\"x\":16,\"y\":0}"
      }

      layout_structure {
        key       = "panelB7BBFC834119BCFA"
        structure = "{\"height\":8,\"width\":8,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelCB15AA259859B527"
        structure = "{\"height\":8,\"width\":8,\"x\":8,\"y\":8}"
      }

      layout_structure {
        key       = "panelD4EC5D425B66E585"
        structure = "{\"height\":8,\"width\":8,\"x\":8,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel2D69927694C3B566"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  ip\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"ip\" as type, user_name, client_name, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and ip matches \"{{ip}}\" \n| where if (\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n| where if (\"{{client_name}}\" = \"*\", true, client_name matches \"{{client_name}}\")\n\n// panel specific\n| where !isBlank(ip)\n| count by ip\n| lookup latitude, longitude, country_code from geo://location on ip = ip\n| where !isNull(latitude)\n| lookup country_code from https://sumologic-app-data.s3.amazonaws.com/riskycountries.csv on country_code=country_code \n| where !isNull(country_code)"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Logins from Risky Countries"
      visual_settings = "{\"general\":{\"mode\":\"map\",\"type\":\"map\"},\"map\":{\"type\":\"geo\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel668C42F29B787B4B"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id type\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and ip matches \"{{ip}}\" \n| where if (\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n| where if (\"{{client_name}}\" = \"*\", true, client_name matches \"{{client_name}}\")\n\n// panel specific\n| where !isBlank(type) and type matches(\"gd_*\") \n| timeslice 1h\n| count by log_id, _timeslice, type\n| count by _timeslice, type\n| fillmissing timeslice, values all in type\n| transpose row _timeslice column type"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Guardian MFA Activity"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"column\",\"displayType\":\"stacked\",\"roundDataPoints\":true,\"fillOpacity\":1},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"overrides\":[],\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel7CA343C9C7543BB6"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  assessments riskAssessment ImpossibleTravel\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"ip\", \"details.riskAssessment.assessments.ImpossibleTravel.code\" as type, user_name, client_name, ip, impossible_travel_code nodrop\n\n// global filters\n| where type matches \"{{type}}\" and ip matches \"{{ip}}\" \n| where if (\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n| where if (\"{{client_name}}\" = \"*\", true, client_name matches \"{{client_name}}\")\n\n// panel specific\n| where !isBlank(impossible_travel_code)\n| count by log_id, impossible_travel_code\n| count by impossible_travel_code\n| sort by _count, impossible_travel_code asc"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Impossible Travel Assessment Distribution"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\"},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel7ED4B79894CB4B48"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id type (\"s\" OR \"fp\" OR \"fu\")\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\" as type, user_name, client_name, connection, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and ip matches \"{{ip}}\" \n| where if (\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n| where if (\"{{client_name}}\" = \"*\", true, client_name matches \"{{client_name}}\")\n\n// panel specific\n| where !isBlank(type) and type in (\"s\", \"fp\", \"fu\")\n| if(type = \"s\", \"success\", \"failure\") as login_result\n| timeslice 1h\n| count by log_id, _timeslice, login_result\n| count by _timeslice, login_result\n| fillmissing timeslice, values all in login_result\n| transpose row _timeslice column login_result"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Login Status Over Time"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"column\",\"displayType\":\"stacked\",\"roundDataPoints\":true,\"fillOpacity\":1},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"overrides\":[],\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel88992B96AEADDA49"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  assessments riskAssessment PhoneNumber\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"ip\", \"details.riskAssessment.assessments.PhoneNumber.code\" as type, user_name, client_name, ip, phone_number_code nodrop\n\n// global filters\n| where type matches \"{{type}}\" and ip matches \"{{ip}}\" \n| where if (\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n| where if (\"{{client_name}}\" = \"*\", true, client_name matches \"{{client_name}}\")\n\n// panel specific\n| where !isBlank(phone_number_code)\n| count by log_id, phone_number_code\n| count by phone_number_code\n| sort by _count, phone_number_code asc"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Phone Number Assessment Distribution"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"innerRadius\":\"30%\"},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8C96833AB3CB2842"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  log_id auth0_client\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"connection\", \"ip\", \"auth0_client.name\", \"auth0_client.version\" as type, user_name, client_name, connection, ip, auth0_client_name, auth0_client_version nodrop\n\n// global filters\n| where type matches \"{{type}}\" and ip matches \"{{ip}}\" \n| where if (\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n| where if (\"{{client_name}}\" = \"*\", true, client_name matches \"{{client_name}}\")\n\n// panel specific\n| where !isBlank(auth0_client_name) and !isBlank(auth0_client_version)\n| concat(auth0_client_name, \" \", auth0_client_version) as auth0_client_version \n| timeslice 1h\n| count by _timeslice, log_id, auth0_client_version \n| count by _timeslice, auth0_client_version \n| transpose row _timeslice column auth0_client_version"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Client Version Usage"
      visual_settings = "{\"general\":{\"mode\":\"timeSeries\",\"type\":\"column\",\"displayType\":\"stacked\",\"roundDataPoints\":true,\"fillOpacity\":1},\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"overrides\":[],\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel93DEF7CF2688984D"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  user_agent\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"ip\", \"user_agent\" as type, user_name, client_name, ip, user_agent nodrop\n\n// global filters\n| where type matches \"{{type}}\" and ip matches \"{{ip}}\" \n| where if (\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n| where if (\"{{client_name}}\" = \"*\", true, client_name matches \"{{client_name}}\")\n\n// panel specific\n| where !isBlank(user_agent)\n| count by log_id, user_agent\n| count as count by user_agent\n| sort by count, user_agent asc\n| limit 10"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Top 10 User Agents"
      visual_settings = "{\"axes\":{\"axisX\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelA594B74F75FAE89E"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  ip user_name\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"ip\" as type, user_name, client_name, ip nodrop\n\n// global filters\n| where type matches \"{{type}}\" and ip matches \"{{ip}}\" \n| where if (\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n| where if (\"{{client_name}}\" = \"*\", true, client_name matches \"{{client_name}}\")\n\n// panel specific\n| where !isBlank(user_name) and !isBlank(ip)\n| count_distinct(ip) as distinct_ips by user_name\n| sort by distinct_ips, user_name asc\n| limit 10"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Top 10 Users by Distinct IP Addresses"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB6126C06ED007427"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  assessments riskAssessment UntrustedIP\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"ip\", \"details.riskAssessment.assessments.UntrustedIP.code\" as type, user_name, client_name, ip, untrusted_ip_code nodrop\n\n// global filters\n| where type matches \"{{type}}\" and ip matches \"{{ip}}\" \n| where if (\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n| where if (\"{{client_name}}\" = \"*\", true, client_name matches \"{{client_name}}\")\n\n// panel specific\n| where !isBlank(untrusted_ip_code)\n| count by log_id, untrusted_ip_code\n| count by untrusted_ip_code\n| sort by _count, untrusted_ip_code asc"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Untrusted IP Assessment Distribution"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\"},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB7BBFC834119BCFA"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  elapsedTime\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"ip\", \"details.elapsedTime\" as type, user_name, client_name, ip, elapsed_time nodrop\n\n// global filters\n| where type matches \"{{type}}\" and ip matches \"{{ip}}\" \n| where if (\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n| where if (\"{{client_name}}\" = \"*\", true, client_name matches \"{{client_name}}\")\n\n// panel specific\n| where !isBlank(elapsed_time)\n| avg(elapsed_time)"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Average Login Elapsed Time (ms)"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"svp\",\"displayType\":\"default\",\"roundDataPoints\":true,\"mode\":\"singleValueMetrics\",\"noDataMessage\":\"0\"},\"svp\":{\"option\":\"Latest\",\"unitify\":false,\"textColor\":\"\",\"backgroundColor\":\"\",\"label\":\"\",\"useBackgroundColor\":false,\"useNoData\":false,\"noDataString\":\"\",\"hideData\":false,\"hideLabel\":false,\"rounding\":2,\"valueFontSize\":24,\"labelFontSize\":14,\"thresholds\":[{\"from\":null,\"to\":null,\"color\":\"#16943E\"},{\"from\":null,\"to\":null,\"color\":\"#DFBE2E\"},{\"from\":null,\"to\":null,\"color\":\"#BF2121\"}],\"sparkline\":{\"show\":false,\"color\":\"#222D3B\"},\"gauge\":{\"show\":false,\"min\":0,\"max\":100,\"showThreshold\":false,\"showThresholdMarker\":false}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelCB15AA259859B527"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  assessments riskAssessment NewDevice\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"ip\", \"details.riskAssessment.assessments.NewDevice.code\" as type, user_name, client_name, ip, new_device_code nodrop\n\n// global filters\n| where type matches \"{{type}}\" and ip matches \"{{ip}}\" \n| where if (\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n| where if (\"{{client_name}}\" = \"*\", true, client_name matches \"{{client_name}}\")\n\n// panel specific\n| where !isBlank(new_device_code)\n| count by log_id, new_device_code\n| count by new_device_code\n| sort by _count, new_device_code asc"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "New Device Assessment Distribution"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\"},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelD4EC5D425B66E585"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  confidence riskAssessment\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"client_name\", \"ip\", \"details.riskAssessment.confidence\" as type, user_name, client_name, ip, risk_confidence nodrop\n\n// global filters\n| where type matches \"{{type}}\" and ip matches \"{{ip}}\" \n| where if (\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n| where if (\"{{client_name}}\" = \"*\", true, client_name matches \"{{client_name}}\")\n\n// panel specific\n| where !isBlank(risk_confidence)\n| count by log_id, risk_confidence\n| count by risk_confidence\n| sort by _count, risk_confidence asc"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Risk Assessment Confidence Distribution"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\"},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"series\":{}}"
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

  title = "Auth0 - Security Analysis"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "client_name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "client_name"

    source_definition {
      log_query_variable_source_definition {
        field = "client_name"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  client_name\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"client_name\" as client_name\n| where !isBlank(client_name)\n| count by client_name\n| sort by client_name asc"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "ip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "ip"

    source_definition {
      log_query_variable_source_definition {
        field = "ip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  ip\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"ip\" as ip\n| where !isBlank(ip)\n| count by ip\n| sort by ip asc"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "type"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "type"

    source_definition {
      log_query_variable_source_definition {
        field = "type"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  type\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\" as type\n| count by type\n| sort by type asc"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "user_name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "user_name"

    source_definition {
      log_query_variable_source_definition {
        field = "user_name"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  user_name\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"user_name\" as user_name\n| where !isBlank(user_name)\n| count by user_name\n| sort by user_name asc"
      }
    }
  }
}

resource "sumologic_dashboard" "auth___user_agent_analysis" {
  description = "The Auth0 - User Agent Analysis dashboard analyzes the user agents, categorizing traffic by browser, operating system, platform, and automated versus human origin. It tracks user-agent activity trends, surfaces the top agents associated with failed activities, and highlights HTTP errors encountered by different client types. Category trend analysis helps teams identify unusual or unauthorized client tooling over time. Use this dashboard to detect bot activity, investigate suspicious client behaviour, and ensure that only approved tools and platforms access your environment."
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
        key       = "panel87FB8B579F5CA844"
        structure = "{\"height\":10,\"width\":12,\"x\":12,\"y\":19}"
      }

      layout_structure {
        key       = "panelC0D71EC584666948"
        structure = "{\"height\":10,\"width\":12,\"x\":12,\"y\":29}"
      }

      layout_structure {
        key       = "panelUA01TBLTOPAGT"
        structure = "{\"height\":10,\"width\":16,\"x\":0,\"y\":9}"
      }

      layout_structure {
        key       = "panelUA02COLTRNDAGT"
        structure = "{\"height\":10,\"width\":12,\"x\":0,\"y\":19}"
      }

      layout_structure {
        key       = "panelUA03COLTRNDCAT"
        structure = "{\"height\":10,\"width\":12,\"x\":0,\"y\":29}"
      }

      layout_structure {
        key       = "panelUA05PIEPLATFRM"
        structure = "{\"height\":9,\"width\":8,\"x\":16,\"y\":0}"
      }

      layout_structure {
        key       = "panelUA06PIEBROWSER"
        structure = "{\"height\":9,\"width\":8,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelUA07PIEOSPRSE"
        structure = "{\"height\":9,\"width\":8,\"x\":8,\"y\":0}"
      }

      layout_structure {
        key       = "panelUA09PIEAUTHVM"
        structure = "{\"height\":10,\"width\":8,\"x\":16,\"y\":9}"
      }

      layout_structure {
        key       = "panelUA10TBLERRAGT"
        structure = "{\"height\":11,\"width\":24,\"x\":0,\"y\":39}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel87FB8B579F5CA844"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  user_agent\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"user_agent\" as type, user_name, user_agent nodrop\n\n| \"Other\" as user_agent_category\n| if (user_agent matches \"*Mozilla*\", \"Browser\", user_agent_category) as user_agent_category\n| if (user_agent matches \"*Postman*\" or user_agent matches \"*insomnia*\", \"API Testing\", user_agent_category) as user_agent_category\n| if (user_agent matches \"*python-requests*\" or user_agent matches \"*httpx*\" or user_agent matches \"*urllib*\", \"Python Client\", user_agent_category) as user_agent_category\n| if (user_agent matches \"*curl*\", \"CLI\", user_agent_category) as user_agent_category\n| if (user_agent matches \"*axios*\" or user_agent matches \"*node*\" or user_agent matches \"*okhttp*\" or user_agent matches \"*Go-http-client*\", \"Programmatic\", user_agent_category) as user_agent_category\n| if (user_agent matches \"*Apache-HttpClient*\", \"Java Client\", user_agent_category) as user_agent_category\n| if (user_agent matches \"*UNKNOWN*\", \"Unknown\", user_agent_category) as user_agent_category\n\n// Global filter\n| where if(\"{{type}}\" = \"*\", true, type matches \"{{type}}\")\n| where if(\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n| where if(\"{{user_agent_category}}\" = \"*\",true,user_agent_category matches \"{{user_agent_category}}\")\n\n// Panel specific\n| where !isBlank(user_agent_category)\n| timeslice 1h\n| count by _timeslice, user_agent_category\n| transpose row _timeslice column user_agent_category"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "User Agent Category Trend"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelC0D71EC584666948"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  user_agent (\"access_failed\" OR \"deletion_failed\" OR \"failed\")\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"user_agent\" as type, user_name, user_agent nodrop\n\n// Global filter\n| where if(\"{{type}}\" = \"*\", true, type matches \"{{type}}\")\n| where if(\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n\n// Panel specific \n| where !isBlank(user_agent)\n| \"Other\" as ua_category\n| if (user_agent matches \"*Mozilla*\", \"Browser\", ua_category) as ua_category\n| if (user_agent matches \"*Postman*\" OR user_agent matches \"*insomnia*\", \"API Testing\", ua_category) as ua_category\n| if (user_agent matches \"*python*\" OR user_agent matches \"*Python*\" OR user_agent matches \"*httpx*\" OR user_agent matches \"*urllib*\", \"Python Client\", ua_category) as ua_category\n| if (user_agent matches \"*curl*\", \"CLI\", ua_category) as ua_category\n| if (user_agent matches \"*axios*\" OR user_agent matches \"*node*\" OR user_agent matches \"*okhttp*\" OR user_agent matches \"*RestSharp*\" OR user_agent matches \"*bruno-runtime*\" OR user_agent matches \"*undici*\" OR user_agent matches \"*Azuqua*\" OR user_agent matches \"*ais*\" OR user_agent matches \"*Go-http-client*\", \"Programmatic\", ua_category) as ua_category\n| if (user_agent matches \"*Apache-HttpClient*\", \"Java Client\", ua_category) as ua_category\n| if (user_agent matches \"*UNKNOWN*\" OR isBlank(user_agent), \"Unknown\", ua_category) as ua_category\n\n| parse regex field=user_agent \"(?<client>^[^/]+)/(?<version>[0-9\\.]+)\" nodrop\n| if (user_agent in (\"node\"), user_agent, client) as client\n| where !isBlank(client)\n| count as frequency by client, version\n| sort by frequency, client asc, version"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "HTTP Errors Faced by User Agents"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelUA01TBLTOPAGT"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  user_agent\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"user_agent\" as type, user_name, user_agent nodrop\n\n// Global filter\n| where if(\"{{type}}\" = \"*\", true, type matches \"{{type}}\")\n| where if(\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n\n// Panel specific\n| where !isBlank(user_agent)\n| count by log_id, user_agent\n| count as frequency by user_agent\n| sort by frequency, user_agent asc"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Top User Agents"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelUA02COLTRNDAGT"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  user_agent\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"user_agent\" as type, user_name, user_agent nodrop\n\n// Global filter\n| where if(\"{{type}}\" = \"*\", true, type matches \"{{type}}\")\n| where if(\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n\n// Panel specific\n| where !isBlank(user_agent)\n| count by log_id, user_agent, _messagetime\n| timeslice 1h\n| count by user_agent, _timeslice\n| fillmissing timeslice, values all in user_agent\n| transpose row _timeslice column user_agent"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "User Agent Activity Trend"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelUA03COLTRNDCAT"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  user_agent\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"user_agent\" as type, user_name, user_agent nodrop\n\n// Global filter\n| where if(\"{{type}}\" = \"*\", true, type matches \"{{type}}\")\n| where if(\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n\n| \"Other\" as ua_category\n| if (user_agent matches \"*Mozilla*\", \"Browser\", ua_category) as ua_category\n| if (user_agent matches \"*Postman*\" OR user_agent matches \"*insomnia*\", \"API Testing\", ua_category) as ua_category\n| if (user_agent matches \"*python*\" OR user_agent matches \"*Python*\" OR user_agent matches \"*httpx*\" OR user_agent matches \"*urllib*\", \"Python Client\", ua_category) as ua_category\n| if (user_agent matches \"*curl*\", \"CLI\", ua_category) as ua_category\n| if (user_agent matches \"*axios*\" OR user_agent matches \"*node*\" OR user_agent matches \"*okhttp*\" OR user_agent matches \"*RestSharp*\" OR user_agent matches \"*bruno-runtime*\" OR user_agent matches \"*undici*\" OR user_agent matches \"*Azuqua*\" OR user_agent matches \"*ais*\" OR user_agent matches \"*Go-http-client*\", \"Programmatic\", ua_category) as ua_category\n| if (user_agent matches \"*Apache-HttpClient*\", \"Java Client\", ua_category) as ua_category\n| if (user_agent matches \"*UNKNOWN*\" OR isBlank(user_agent), \"Unknown\", ua_category) as ua_category\n\n// Panel specific\n| where if(\"{{user_agent_category}}\" = \"*\", true, ua_category matches \"{{user_agent_category}}\")\n| where !isBlank(user_agent)\n| count by log_id, ua_category\n| count as frequency by ua_category\n| sort by frequency, ua_category asc"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Top User Agent Categories"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"distribution\"}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelUA05PIEPLATFRM"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  user_agent\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"user_agent\" as type, user_name, user_agent nodrop\n\n// Global filter\n| where if(\"{{type}}\" = \"*\", true, type matches \"{{type}}\")\n| where if(\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n\n// Panel specific\n| if (user_agent matches \"*iPad*\" OR user_agent matches \"*iPhone*\" OR user_agent matches \"*Android*\" OR user_agent matches \"*Windows Phone*\" OR user_agent matches \"*Mobile Safari*\", \"Mobile\", \"\") as platform\n| if (user_agent matches \"*Windows*\" OR user_agent matches \"*Win64*\" OR user_agent matches \"*Win32*\", \"PC\", platform) as platform\n| if (user_agent matches \"*Macintosh*\" OR user_agent matches \"*Mac OS*\", \"Mac\", platform) as platform\n| if (platform = \"\", \"Bots/Unknown\", platform) as platform\n| count by log_id, platform\n| count by platform\n| sort by _count, platform asc"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Activity by Platform"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelUA06PIEBROWSER"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  user_agent\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"user_agent\" as type, user_name, user_agent nodrop\n\n// Global filter\n| where if(\"{{type}}\" = \"*\", true, type matches \"{{type}}\")\n| where if(\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n\n// Panel specific\n| if (user_agent matches \"*Windows *\" OR user_agent matches \"*Win32*\" OR user_agent matches \"*Win64*\",\"Windows\",\"\") as OS\n| if (user_agent matches \"*Macintosh*\" OR user_agent matches \"*Darwin/*\" OR user_agent matches \"*Mac OS*\",\"MacOS\",OS) as OS\n| if (user_agent matches \"* CrOS *\",\"Chrome OS\",OS) as OS\n| if (user_agent matches \"*Linux*\",\"Linux\",OS) as OS\n| if (user_agent matches \"*iPad*\",\"iPad\",OS) as OS\n| if (user_agent matches \"*iPhone*\",\"iPhone\",OS) as OS\n| if (user_agent matches \"*Android*\",\"Android\",OS) as OS\n| if (user_agent matches \"*Windows Phone*\",\"Windows Phone\",OS) as OS\n| if (OS = \"\",\"Other\",OS) as OS\n| \"\" as browser\n| if (user_agent matches \"*MSIE*\",\"Internet Explorer\",browser) as browser\n| if (user_agent matches \"*Firefox*\",\"Firefox\",browser) as browser\n| if (user_agent matches \"*Chrome*\",\"Chrome\",browser) as browser\n| if (user_agent matches \"*Safari*\" AND browser = \"\",\"Safari\",browser) as browser\n| if (OS=\"Android\" AND user_agent matches \"*WebKit*\" AND browser = \"\",\"WebKit\",browser) as browser\n| if ((OS=\"iPhone\" OR OS=\"iPad\") AND user_agent matches \"*Mobile/*\" AND browser = \"\",\"Mobile Safari\",browser) as browser\n| if (user_agent matches \"*MobileSafari/*\",\"Mobile Safari\",browser) as browser\n| if (user_agent matches \"Opera*\",\"Opera\",browser) as browser\n| if (user_agent matches \"Dolphin*\",\"Dolphin\",browser) as browser\n| if (browser = \"\",\"Other\",browser) as browser\n| count by log_id, browser\n| count by browser\n| sort by _count, browser asc"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Activity by Browser"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelUA07PIEOSPRSE"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  user_agent\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"user_agent\" as type, user_name, user_agent nodrop\n\n// Global filter\n| where if(\"{{type}}\" = \"*\", true, type matches \"{{type}}\")\n| where if(\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n\n// Panel specific\n| if (user_agent matches \"*Windows *\" OR user_agent matches \"*Win32*\" OR user_agent matches \"*Win64*\",\"Windows\",\"\") as OS\n| if (user_agent matches \"*Macintosh*\" OR user_agent matches \"*Darwin/*\" OR user_agent matches \"*Mac OS*\",\"MacOS\",OS) as OS\n| if (user_agent matches \"* CrOS *\",\"Chrome OS\",OS) as OS\n| if (user_agent matches \"*Linux*\",\"Linux\",OS) as OS\n| if (user_agent matches \"*iPad*\",\"iPad\",OS) as OS\n| if (user_agent matches \"*iPhone*\",\"iPhone\",OS) as OS\n| if (user_agent matches \"*Android*\",\"Android\",OS) as OS\n| if (user_agent matches \"*Windows Phone*\",\"Windows Phone\",OS) as OS\n| if (OS = \"\",\"Other\",OS) as OS\n| count by log_id, OS\n| count by OS\n| sort by _count, OS asc"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Activity by Operating System"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelUA09PIEAUTHVM"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  user_agent\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"user_agent\" as type, user_name, user_agent nodrop\n\n// Global filter\n| where if(\"{{type}}\" = \"*\", true, type matches \"{{type}}\")\n| where if(\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n\n// Panel specific\n| if (user_agent matches \"*Mozilla*\", \"Human (Browser)\", \"Automated\") as traffic_type\n| count by log_id, traffic_type\n| count by traffic_type\n| sort by _count, traffic_type asc"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Automated vs Human Traffic Ratio"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":10,\"mode\":\"distribution\"},\"legend\":{\"enabled\":false,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelUA10TBLERRAGT"

      query {
        output_cardinality_limit = "1000"
        parse_mode               = "Auto"
        query_key                = "A"
        query_string             = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  user_agent (\"fp\" OR \"fu\" OR \"gd_auth_failed\")\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\", \"user_name\", \"user_agent\", \"ip\" as type, user_name, user_agent, ip nodrop\n\n// Global filter\n| where if(\"{{type}}\" = \"*\", true, type matches \"{{type}}\")\n| where if(\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n\n// Panel specific - failed event types only\n| where !isBlank(user_agent)\n| \"Other\" as ua_category\n| if (user_agent matches \"*Mozilla*\", \"Browser\", ua_category) as ua_category\n| if (user_agent matches \"*Postman*\" OR user_agent matches \"*insomnia*\", \"API Testing\", ua_category) as ua_category\n| if (user_agent matches \"*python-requests*\" OR user_agent matches \"*httpx*\" OR user_agent matches \"*urllib*\", \"Python Client\", ua_category) as ua_category\n| if (user_agent matches \"*curl*\", \"CLI\", ua_category) as ua_category\n| if (user_agent matches \"*axios*\" OR user_agent matches \"*node*\" OR user_agent matches \"*okhttp*\" OR user_agent matches \"*Go-http-client*\", \"Programmatic\", ua_category) as ua_category\n| if (user_agent matches \"*Apache-HttpClient*\", \"Java Client\", ua_category) as ua_category\n| if (user_agent matches \"*UNKNOWN*\" OR isBlank(user_agent), \"Unknown\", ua_category) as ua_category\n| parse regex field=user_agent \"(?<client>^[^/]+)/(?<version>[0-9\\.]+)\" nodrop\n\n| where type in (\"fp\", \"fu\", \"gd_auth_failed\")\n| if (isBlank(client), user_agent, client) as client\n| count by log_id, ua_category, client, version, type, ip, user_name\n| count as frequency by ua_category, client, version, type, ip, user_name\n| sort by frequency, ua_category asc, client asc\n| limit 1000"
        query_type               = "Logs"
        time_source              = "Message"
        transient                = "false"
      }

      title           = "Top User Agents for Failed Activities"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"roundDataPoints\":true,\"paginationPageSize\":10,\"fontSize\":12,\"mode\":\"distribution\"}}"
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

  title = "Auth0 - User Agent Analysis"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "type"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "type"

    source_definition {
      log_query_variable_source_definition {
        field = "type"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  type\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"type\" as type\n| count by type\n| sort by type asc"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "user_agent_category"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "user_agent_category"

    source_definition {
      csv_variable_source_definition {
        values = "Browser,API Testing,Python Client,CLI,Programmatic,Java Client,Unknown,Other"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "user_name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "user_name"

    source_definition {
      log_query_variable_source_definition {
        field = "user_name"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  user_name\n| json \"data\", \"log_id\", \"detail.data\", \"detail.log_id\" as data, log_id, data2, log_id2 nodrop\n| if (!isEmpty(data), data, data2) as data\n| if (!isEmpty(log_id), log_id, log_id2) as log_id\n| json field=data \"user_name\" as user_name\n| where !isBlank(user_name)\n| count by user_name\n| sort by user_name asc"
      }
    }
  }
}
