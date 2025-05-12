resource "sumologic_dashboard" "auth___connections_and_clients" {
  description = "The Auth0 - Connections and Clients dashboard provides visibility into authentication trends by client, country, and connection type. It features stacked bar charts showing successful logins by client and country over the last 24 hours and per day over the past week, highlighting client popularity. A timeline of connection types used over the past seven days helps track authentication method trends. Additionally, a client version usage chart monitors Auth0 library versions to detect outdated clients and track upgrades. The dashboard also includes a table of the Top 10 Clients and a list of the Top 10 Recent Errors, offering insights into client activity and aiding in troubleshooting authentication issues."
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
        key       = "panel19d4651f970c694d"
        structure = "{\"width\":12,\"height\":9,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panel525f0e11bf2b2b4c"
        structure = "{\"width\":12,\"height\":9,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panela5e4efb0a453fb44"
        structure = "{\"width\":10,\"height\":6,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panele7270d098756594e"
        structure = "{\"width\":8,\"height\":13,\"x\":16,\"y\":7}"
      }

      layout_structure {
        key       = "panelf500773eacfc9b4c"
        structure = "{\"width\":6,\"height\":13,\"x\":10,\"y\":7}"
      }

      layout_structure {
        key       = "panelf8757ebfae9ae845"
        structure = "{\"width\":10,\"height\":6,\"x\":0,\"y\":7}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel19d4651f970c694d"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description\n| where client_name matches \"*\" and type = \"s\" | timeslice by 1d\n|where if (\"{{client_name}}\" = \"*\", true, client_name matches \"{{client_name}}\")\n|count by _timeslice, client_name | transpose row _timeslice column client_name"
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

      title           = "Logins by Client per Day"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":true,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}},\"highlightViolations\":true},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel525f0e11bf2b2b4c"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}\n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description\n| where type = \"s\"\n| lookup country_name from geo://location on ip=ip\n|where if (\"*\" = \"*\", true, client_name matches \"*\") AND if (\"*\" = \"*\", true, country_name matches \"*\")\n|count by client_name, country_name\n| transpose row client_name column country_name"
        query_type   = "Logs"
      }

      title           = "Logins by Client and Country"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":true,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}},\"highlightViolations\":true}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panela5e4efb0a453fb44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | json \"data.auth0_client.name\", \"data.auth0_client.version\" | concat(%data.auth0_client.name, \" \", %data.auth0_client.version) as auth0_client_version | timeslice 1h\n|where if (\"{{auth0_client_version}}\" = \"*\", true, auth0_client_version matches \"{{auth0_client_version}}\")\n|count by _timeslice, auth0_client_version | transpose row _timeslice column auth0_client_version"
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

      title           = "Client Version Usage"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":null,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":true,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}},\"highlightViolations\":true},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panele7270d098756594e"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description\n| where type<>\"slo\"\n|where if (\"{{client_name}}\" = \"*\", true, client_name matches \"{{client_name}}\") AND if (\"{{connection}}\" = \"*\", true, connection matches \"{{connection}}\")\n|count client_name, connection, description | top 10 client_name, connection, description by _count"
        query_type   = "Logs"
      }

      title           = "Top 10 Recent Errors"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}},\"highlightViolations\":true}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelf500773eacfc9b4c"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}\n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description\n| where !isEmpty(client_name)\n|where if (\"{{client_name}}\" = \"*\", true, client_name matches \"{{client_name}}\")\n|count client_name | top 10 client_name by _count"
        query_type   = "Logs"
      }

      title           = "Top 10 Clients"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}},\"highlightViolations\":true}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelf8757ebfae9ae845"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description\n| where connection matches \"*\" | timeslice by 1h\n|where if (\"{{connection}}\" = \"*\", true, connection matches \"{{connection}}\")\n|count by _timeslice, connection | transpose row _timeslice column connection"
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

      title           = "Connection Types per Hour"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":null,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":true,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}},\"highlightViolations\":true},\"overrides\":[]}"
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

  title = "Auth0 - Connections and Clients"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "auth0_client_version"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "auth0_client_version"

    source_definition {
      log_query_variable_source_definition {
        field = "auth0_client_version"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | json \"auth0_client.name\", \"auth0_client.version\" | concat(%auth0_client.name, \" \", %auth0_client.version) as auth0_client_version | timeslice 1h"
      }
    }
  }

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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| %\"data.type\" as type |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip\n| where type = \"s\"\n| lookup country_name from geo://location on ip=ip"
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| %\"data.connection\" as connection\n| where connection matches \"*\" | timeslice by 1h"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "country_name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "country_name"

    source_definition {
      log_query_variable_source_definition {
        field = "country_name"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n|  %\"data.type\" as type |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip\n| where type = \"s\"\n| lookup country_name from geo://location on ip=ip"
      }
    }
  }
}

resource "sumologic_dashboard" "auth___overview" {
  description = "The Auth0 - Overview dashboard provides insights into authentication activity, tracking login geolocations on a world map and visualizing login attempts per hour over the last seven days. It highlights the top users by successful and failed logins, as well as the most frequent source IPs for failed logins, helping to identify potential security threats. Additionally, it presents the most common user agents and operating systems in pie charts, offering visibility into device trends. Guardian MFA activity is also monitored in a timeline chart, displaying authentication events per hour to enhance security oversight."
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
        key       = "panel2041ef09a7aff84f"
        structure = "{\"width\":8,\"height\":8,\"x\":16,\"y\":6}"
      }

      layout_structure {
        key       = "panel6669d0ba93589b46"
        structure = "{\"width\":8,\"height\":8,\"x\":8,\"y\":6}"
      }

      layout_structure {
        key       = "panel677ef2aea97fc849"
        structure = "{\"width\":16,\"height\":13,\"x\":8,\"y\":12}"
      }

      layout_structure {
        key       = "panel748247089b97594d"
        structure = "{\"width\":8,\"height\":8,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panel7e7ad3948c49cb4e"
        structure = "{\"width\":16,\"height\":8,\"x\":8,\"y\":0}"
      }

      layout_structure {
        key       = "panel879d02ffaffc2945"
        structure = "{\"width\":8,\"height\":8,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panel8af492638c5e694a"
        structure = "{\"width\":8,\"height\":6,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panelf01a414eabb8a84c"
        structure = "{\"width\":8,\"height\":6,\"x\":0,\"y\":17}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel2041ef09a7aff84f"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description |  %\"data.user_name\" as user_name |  %\"data.user_agent\" as user_agent\n| where type in (\"fp\", \"fu\") | where !isEmpty(ip)\n|where if (\"{{ip}}\" = \"*\", true, ip matches \"{{ip}}\")\n|count ip | top 10 ip by _count"
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

      title           = "Top10 Source IPs by Failed Login"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}},\"highlightViolations\":true}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel6669d0ba93589b46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description |  %\"data.user_name\" as user_name |  %\"data.user_agent\" as user_agent\n| where type in (\"fp\", \"fu\") | where !isEmpty(user_name)\n|where if (\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n|count user_name | top 10 user_name by _count"
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

      title           = "Top 10 Users by Failed Login"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}},\"highlightViolations\":true}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel677ef2aea97fc849"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description |  %\"data.user_name\" as user_name |  %\"data.user_agent\" as user_agent\n| where type matches(\"gd_*\") | timeslice by 1h\n|where if (\"{{type}}\" = \"*\", true, type matches \"{{type}}\")\n|count by _timeslice, type | transpose row _timeslice column type"
        query_type   = "Logs"
      }

      title           = "Guardian MFA Activity"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":null,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":true,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}},\"highlightViolations\":true},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel748247089b97594d"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description |  %\"data.user_name\" as user_name |  %\"data.user_agent\" as user_agent\n| where type = \"s\"\n| lookup latitude, longitude, country_code, country_name, region, city from geo://location on ip = ip\n|where if (\"{{country_code}}\" = \"*\", true, country_code matches \"{{country_code}}\") AND if (\"{{country_name}}\" = \"*\", true, country_name matches \"{{country_name}}\")\n|count by latitude, longitude, country_code, country_name, region, city\n| sort _count"
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

      title           = "Login Event Geolocation"
      visual_settings = "{\"general\":{\"mode\":\"map\",\"type\":\"map\"},\"map\":{\"mainMetric\":{\"layerType\":\"Cluster\"}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel7e7ad3948c49cb4e"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description |  %\"data.user_name\" as user_name |  %\"data.user_agent\" as user_agent\n| if(type in (\"fp\", \"fu\"), \"failure\", if(type = \"s\", \"success\", \"-\")) as login_result\n| where login_result != \"-\"\n| timeslice 1h\n| count by _timeslice, login_result\n| transpose row _timeslice column login_result"
        query_type   = "Logs"
      }

      title           = "Logins per Hour"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":null,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":true,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}},\"highlightViolations\":true},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel879d02ffaffc2945"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description |  %\"data.user_name\" as user_name |  %\"data.user_agent\" as user_agent\n| where type = \"s\" | where !isEmpty(user_name)\n|where if (\"{{user_name}}\" = \"*\", true, user_name matches \"{{user_name}}\")\n|count user_name | top 10 user_name by _count"
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

      title           = "Top 10 Users by Successful Login"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"numberThresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}},\"highlightViolations\":true}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8af492638c5e694a"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description |  %\"data.user_name\" as user_name |  %\"data.user_agent\" as user_agent\n| parse field=user_agent \"* \" as user_agent\n|where if (\"{{user_agent}}\" = \"*\", true, user_agent matches \"{{user_agent}}\")\n|count user_agent | top 10 user_agent by _count"
        query_type   = "Logs"
      }

      title           = "Top 10 User Agents"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":\"10\",\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":true,\"wrap\":true,\"verticalAlign\":\"right\",\"showAsTable\":true}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelf01a414eabb8a84c"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description |  %\"data.user_name\" as user_name |  %\"data.user_agent\" as user_agent\n| parse field=user_agent \"* (*; *;*)\" as user_agent_part1, user_os, user_agent_part2, user_agent_part3 nodrop\n| where !isBlank(user_os)\n|where if (\"{{user_os}}\" = \"*\", true, user_os matches \"{{user_os}}\")\n|count_distinct(user_name) group by user_os | top 10 user_os by _count_distinct"
        query_type   = "Logs"
      }

      title           = "Top 10 Operating Systems"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":\"10\",\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":true,\"wrap\":true,\"verticalAlign\":\"right\",\"showAsTable\":true}}"
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

  title = "Auth0 - Overview"

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "country_code"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "country_code"

    source_definition {
      log_query_variable_source_definition {
        field = "country_code"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description |  %\"data.user_name\" as user_name |  %\"data.user_agent\" as user_agent\n| where type = \"s\"\n| lookup latitude, longitude, country_code, country_name, region, city from geo://location on ip = ip"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "country_name"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "country_name"

    source_definition {
      log_query_variable_source_definition {
        field = "country_name"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}} \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description |  %\"data.user_name\" as user_name |  %\"data.user_agent\" as user_agent\n| where type = \"s\"\n| lookup latitude, longitude, country_code, country_name, region, city from geo://location on ip = ip"
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description |  %\"data.user_name\" as user_name |  %\"data.user_agent\" as user_agent\n| where type in (\"fp\", \"fu\") | where !isEmpty(ip)"
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description |  %\"data.user_name\" as user_name |  %\"data.user_agent\" as user_agent\n| where type matches(\"gd_*\") | timeslice by 1h"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "user_agent"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "user_agent"

    source_definition {
      log_query_variable_source_definition {
        field = "user_agent"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description |  %\"data.user_name\" as user_name |  %\"data.user_agent\" as user_agent\n| parse field=user_agent \"* \" as user_agent"
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description |  %\"data.user_name\" as user_name |  %\"data.user_agent\" as user_agent\n| where type in (\"fp\", \"fu\") | where !isEmpty(user_name)"
      }
    }
  }

  variable {
    allow_multi_select = "false"
    default_value      = "*"
    display_name       = "user_os"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "user_os"

    source_definition {
      log_query_variable_source_definition {
        field = "user_os"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \n| %\"data.date\" as date |  %\"data.type\" as type |  %\"data.client_id\" as client_id |  %\"data.client_name\" as client_name |  %\"data.ip\" as ip |  %\"data.user_id\" as user_id | %\"data.connection\" as connection |  %\"data.description\" as description |  %\"data.user_name\" as user_name |  %\"data.user_agent\" as user_agent\n| parse field=user_agent \"* (*; *;*)\" as user_agent_part1, user_os, user_agent_part2, user_agent_part3 nodrop\n| where !isBlank(user_os)"
      }
    }
  }
}
