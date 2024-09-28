resource "sumologic_dashboard" "amazon_ses_bounced_notifications" {
  description = "See details of bounced notifications by email addresses, domains, bounce types, and bounce subtypes."
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
        key       = "panel0265dd5d8648db4c"
        structure = "{\"width\":5,\"height\":9,\"x\":0,\"y\":8}"
      }

      layout_structure {
        key       = "panel0a8f3efc9e1e8b4c"
        structure = "{\"width\":6,\"height\":9,\"x\":12,\"y\":8}"
      }

      layout_structure {
        key       = "panel0ffc19b6915f394f"
        structure = "{\"width\":6,\"height\":9,\"x\":18,\"y\":8}"
      }

      layout_structure {
        key       = "panel1036a8359401fa44"
        structure = "{\"width\":6,\"height\":9,\"x\":0,\"y\":15}"
      }

      layout_structure {
        key       = "panel4ded15dc90ef8840"
        structure = "{\"width\":12,\"height\":9,\"x\":12,\"y\":22}"
      }

      layout_structure {
        key       = "panel87d604e3a7740943"
        structure = "{\"width\":6,\"height\":9,\"x\":0,\"y\":1}"
      }

      layout_structure {
        key       = "panel8ea1e57898a3484b"
        structure = "{\"width\":24,\"height\":1,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panel97828ff5a5e92848"
        structure = "{\"width\":7,\"height\":9,\"x\":5,\"y\":8}"
      }

      layout_structure {
        key       = "panel9d6639199c557b44"
        structure = "{\"width\":12,\"height\":9,\"x\":0,\"y\":22}"
      }

      layout_structure {
        key       = "panel9db4a8a7bb1d994e"
        structure = "{\"width\":6,\"height\":9,\"x\":6,\"y\":1}"
      }

      layout_structure {
        key       = "panelc8ef64ddad7fa94a"
        structure = "{\"width\":12,\"height\":9,\"x\":12,\"y\":1}"
      }

      layout_structure {
        key       = "panele1edcc718b82aa46"
        structure = "{\"width\":12,\"height\":9,\"x\":12,\"y\":15}"
      }

      layout_structure {
        key       = "panele7fbb3a9b316db4e"
        structure = "{\"width\":6,\"height\":9,\"x\":6,\"y\":15}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel0265dd5d8648db4c"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\" \"\\\"bounceType\\\":\\\"Transient\\\"\" \"\\\"bounceSubType\\\":\\\"MailboxFull\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\" and bounceType=\"Transient\" and bounceSubType=\"MailboxFull\"\n|where bouncetype matches \"{{bouncetype}}\" AND bouncedemailaddress matches \"{{bouncedemailaddress}}\" AND domain matches \"{{domain}}\" AND bouncedrecipients matches \"{{bouncedrecipients}}\" AND bouncesubtype matches \"{{bouncesubtype}}\" AND name matches \"{{name}}\"\n|count as eventCount by BouncedemailAddress\n| sort by eventCount, BouncedemailAddress\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Transient Bounce - MailBox Full"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel0a8f3efc9e1e8b4c"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\" \"\\\"bounceType\\\":\\\"Transient\\\"\" \"\\\"bounceSubType\\\":\\\"General\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\" and bounceType=\"Transient\" and bounceSubType=\"General\"\n|where bouncetype matches \"{{bouncetype}}\" AND bouncedemailaddress matches \"{{bouncedemailaddress}}\" AND domain matches \"{{domain}}\" AND bouncedrecipients matches \"{{bouncedrecipients}}\" AND bouncesubtype matches \"{{bouncesubtype}}\" AND name matches \"{{name}}\"\n|count as eventCount by BouncedemailAddress\n| sort by eventCount, BouncedemailAddress\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Transient Bounce - General"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel0ffc19b6915f394f"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\" \"\\\"bounceType\\\":\\\"Transient\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\" and bounceType=\"Transient\"\n|where bouncetype matches \"{{bouncetype}}\" AND bouncedemailaddress matches \"{{bouncedemailaddress}}\" AND domain matches \"{{domain}}\" AND bouncedrecipients matches \"{{bouncedrecipients}}\" AND bouncesubtype matches \"{{bouncesubtype}}\" AND name matches \"{{name}}\"\n|count as eventCount by bounceSubType\n| sort by eventCount, bounceSubType"
        query_type   = "Logs"
      }

      title           = "Transient Bounce - SubType Breakup"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":\"10\",\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel1036a8359401fa44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\" \"\\\"bounceType\\\":\\\"Permanent\\\"\" \"\\\"bounceSubType\\\":\\\"Suppressed\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop \n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\" and bounceType=\"Permanent\" and bounceSubType=\"Suppressed\"\n|where bouncetype matches \"{{bouncetype}}\" AND bouncedemailaddress matches \"{{bouncedemailaddress}}\" AND domain matches \"{{domain}}\" AND bouncedrecipients matches \"{{bouncedrecipients}}\" AND bouncesubtype matches \"{{bouncesubtype}}\" AND name matches \"{{name}}\"\n|count as eventCount by BouncedemailAddress\n| sort by eventCount, BouncedemailAddress\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Permanent Bounce - Suppressed"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel4ded15dc90ef8840"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\" \"\\\"bounceType\\\":\\\"Undetermined\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\" and bounceType=\"Undetermined\"\n| timeslice 15m\n|where bouncetype matches \"{{bouncetype}}\" AND bouncedemailaddress matches \"{{bouncedemailaddress}}\" AND domain matches \"{{domain}}\" AND bouncedrecipients matches \"{{bouncedrecipients}}\" AND bouncesubtype matches \"{{bouncesubtype}}\" AND name matches \"{{name}}\"\n|count by _timeslice, bounceSubType \n| transpose row _timeslice column bounceSubType"
        query_type   = "Logs"
      }

      title           = "Undetermined Bounce - Sub Type Trend"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel87d604e3a7740943"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\"\n|where bouncetype matches \"{{bouncetype}}\" AND bouncedemailaddress matches \"{{bouncedemailaddress}}\" AND domain matches \"{{domain}}\" AND bouncedrecipients matches \"{{bouncedrecipients}}\" AND bouncesubtype matches \"{{bouncesubtype}}\" AND name matches \"{{name}}\"\n|count as eventCount by BouncedemailAddress\n| sort by eventCount, BouncedemailAddress\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Top Bounced email Addresses"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel97828ff5a5e92848"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\" \"\\\"bounceType\\\":\\\"Transient\\\"\" \"\\\"bounceSubType\\\":\\\"ContentRejected\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n|where bouncetype matches \"{{bouncetype}}\" AND bouncedemailaddress matches \"{{bouncedemailaddress}}\" AND domain matches \"{{domain}}\" AND bouncedrecipients matches \"{{bouncedrecipients}}\" AND bouncesubtype matches \"{{bouncesubtype}}\" AND name matches \"{{name}}\"\n|count as eventCount by BouncedemailAddress\n| sort by eventCount, BouncedemailAddress\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Transient Bounce - Content Rejected"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel9d6639199c557b44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\" \"\\\"bounceType\\\":\\\"Permanent\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\" and bounceType=\"Permanent\"\n| timeslice 15m\n|where bouncetype matches \"{{bouncetype}}\" AND bouncedemailaddress matches \"{{bouncedemailaddress}}\" AND domain matches \"{{domain}}\" AND bouncedrecipients matches \"{{bouncedrecipients}}\" AND bouncesubtype matches \"{{bouncesubtype}}\" AND name matches \"{{name}}\"\n|count by _timeslice, bounceSubType \n| transpose row _timeslice column bounceSubType"
        query_type   = "Logs"
      }

      title           = "Permanent Bounce - Sub Type Trend"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel9db4a8a7bb1d994e"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\"\n|where bouncetype matches \"{{bouncetype}}\" AND bouncedemailaddress matches \"{{bouncedemailaddress}}\" AND domain matches \"{{domain}}\" AND bouncedrecipients matches \"{{bouncedrecipients}}\" AND bouncesubtype matches \"{{bouncesubtype}}\" AND name matches \"{{name}}\"\n|count as eventCount by domain\n| sort by eventCount, domain asc\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Top Bounced email Domains"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelc8ef64ddad7fa94a"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\"\n| timeslice 15m\n|where bouncetype matches \"{{bouncetype}}\" AND bouncedemailaddress matches \"{{bouncedemailaddress}}\" AND domain matches \"{{domain}}\" AND bouncedrecipients matches \"{{bouncedrecipients}}\" AND bouncesubtype matches \"{{bouncesubtype}}\" AND name matches \"{{name}}\"\n|count by _timeslice, bounceType \n| transpose row _timeslice column bounceType"
        query_type   = "Logs"
      }

      title           = "Bounce Type Trend"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panele1edcc718b82aa46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\" \"\\\"bounceType\\\":\\\"Transient\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\" and bounceType=\"Transient\"\n| timeslice 15m\n|where bouncetype matches \"{{bouncetype}}\" AND bouncedemailaddress matches \"{{bouncedemailaddress}}\" AND domain matches \"{{domain}}\" AND bouncedrecipients matches \"{{bouncedrecipients}}\" AND bouncesubtype matches \"{{bouncesubtype}}\" AND name matches \"{{name}}\"\n|count by _timeslice, bounceSubType \n| transpose row _timeslice column bounceSubType"
        query_type   = "Logs"
      }

      title           = "Transient Bounce - Sub Type Trend"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panele7fbb3a9b316db4e"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\" \"\\\"bounceType\\\":\\\"Permanent\\\"\" \"\\\"bounceSubType\\\":\\\"General\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop \n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\" and bounceType=\"Permanent\" and bounceSubType=\"General\"\n|where bouncetype matches \"{{bouncetype}}\" AND bouncedemailaddress matches \"{{bouncedemailaddress}}\" AND domain matches \"{{domain}}\" AND bouncedrecipients matches \"{{bouncedrecipients}}\" AND bouncesubtype matches \"{{bouncesubtype}}\" AND name matches \"{{name}}\"\n|count as eventCount by BouncedemailAddress\n| sort by eventCount, BouncedemailAddress\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Permanent Bounce - General"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8ea1e57898a3484b"
      title                                       = "Bounced Notifications"
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

  title = "Amazon SES - Bounced Notifications"

  variable {
    allow_multi_select = "false"
    display_name       = "bouncedemailaddress"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "bouncedemailaddress"

    source_definition {
      log_query_variable_source_definition {
        field = "bouncedemailaddress"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "bouncedrecipients"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "bouncedrecipients"

    source_definition {
      log_query_variable_source_definition {
        field = "bouncedrecipients"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "bouncesubtype"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "bouncesubtype"

    source_definition {
      log_query_variable_source_definition {
        field = "bouncesubtype"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "bouncetype"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "bouncetype"

    source_definition {
      log_query_variable_source_definition {
        field = "bouncetype"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\""
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\""
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Bounce\\\"\"\n| json \"notificationType\" nodrop | json \"bounce.bounceSubType\" as bounceSubType nodrop | json \"bounce.bounceType\" as bounceType nodrop | json \"bounce.bouncedRecipients\" as bouncedRecipients nodrop\n| parse regex field=bouncedRecipients \"\\\"emailAddress\\\":\\\"(?<BouncedemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=BouncedemailAddress \"*@*\" as name, domain\n| where notificationType=\"Bounce\""
      }
    }
  }
}

resource "sumologic_dashboard" "amazon_ses_cloud_trail_events_by_event_name" {
  description = "See details of various SES CloudTrail events, including the identity, get send, domain, receipt, and email address events."
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
        key       = "panel1bb7d933b32f5845"
        structure = "{\"width\":18,\"height\":6,\"x\":6,\"y\":10}"
      }

      layout_structure {
        key       = "panel45e0526a982cb948"
        structure = "{\"width\":18,\"height\":6,\"x\":6,\"y\":0}"
      }

      layout_structure {
        key       = "panel56e01ba096d40a46"
        structure = "{\"width\":6,\"height\":6,\"x\":0,\"y\":15}"
      }

      layout_structure {
        key       = "panel5aa06897bd8dab4b"
        structure = "{\"width\":6,\"height\":6,\"x\":0,\"y\":5}"
      }

      layout_structure {
        key       = "panel8064aa5cbb819a4c"
        structure = "{\"width\":18,\"height\":6,\"x\":6,\"y\":5}"
      }

      layout_structure {
        key       = "panela01a83afbdd72947"
        structure = "{\"width\":6,\"height\":6,\"x\":0,\"y\":20}"
      }

      layout_structure {
        key       = "panelbaa4a6b0a28fcb46"
        structure = "{\"width\":6,\"height\":6,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelc7522d31ad193940"
        structure = "{\"width\":18,\"height\":6,\"x\":6,\"y\":20}"
      }

      layout_structure {
        key       = "panele3d5c49091cf2943"
        structure = "{\"width\":18,\"height\":6,\"x\":6,\"y\":15}"
      }

      layout_structure {
        key       = "panelf68b7d6aa80b9941"
        structure = "{\"width\":6,\"height\":6,\"x\":0,\"y\":10}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel1bb7d933b32f5845"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" *Domain*\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\" and eventname matches \"*Domain*\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| count as eventCount by eventTime, eventName, eventType, type, user, awsRegion, sourceIPAddress, eventStatus, accountId, requestID, errorCode, errorMessage\n| sort by eventTime"
        query_type   = "Logs"
      }

      title           = "Domain Event Details"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel45e0526a982cb948"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" *Identit*\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\" and eventname matches \"*Identit*\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| count as eventCount by eventTime, eventName, eventType, type, user, awsRegion, sourceIPAddress, eventStatus, accountId, requestID, errorCode, errorMessage\n| sort by eventTime"
        query_type   = "Logs"
      }

      title           = "Identity Event Details"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel56e01ba096d40a46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" *Receipt*\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventname matches \"*Receipt*\"\n| if (isEmpty(userName), user, userName) as user\n| count as eventCount by eventname\n| sort by eventCount, eventname asc"
        query_type   = "Logs"
      }

      title           = "Receipt Events"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":\"10\",\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel5aa06897bd8dab4b"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" GetSend*\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\" and eventname matches \"GetSend*\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| count as eventCount by eventname\n| sort by eventCount, eventname asc"
        query_type   = "Logs"
      }

      title           = "Get Send Events"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":\"10\",\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8064aa5cbb819a4c"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" GetSend*\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\" and eventname matches \"GetSend*\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| count as eventCount by eventTime, eventName, eventType, type, user, awsRegion, sourceIPAddress, eventStatus, accountId, requestID, errorCode, errorMessage\n| sort by eventTime"
        query_type   = "Logs"
      }

      title           = "Get Send Event Details"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panela01a83afbdd72947"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" *EmailAddress*\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventname matches \"*EmailAddress*\"\n| if (isEmpty(userName), user, userName) as user\n| count as eventCount by eventname\n| sort by eventCount, eventname asc"
        query_type   = "Logs"
      }

      title           = "Email Address Events"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":\"10\",\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelbaa4a6b0a28fcb46"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" *Identit*\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventname matches \"*Identit*\"\n| if (isEmpty(userName), user, userName) as user\n| count as eventCount by eventname\n| sort by eventCount, eventname asc"
        query_type   = "Logs"
      }

      title           = "Identity Events"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":\"10\",\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelc7522d31ad193940"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" *EmailAddress*\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventname matches \"*EmailAddress*\"\n| if (isEmpty(userName), user, userName) as user\n| count as eventCount by eventTime, eventName, eventType, type, user, awsRegion, sourceIPAddress, eventStatus, accountId, requestID, errorCode, errorMessage\n| sort by eventTime"
        query_type   = "Logs"
      }

      title           = "Email Address Event Details"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panele3d5c49091cf2943"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" *Receipt*\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventname matches \"*Receipt*\"\n| if (isEmpty(userName), user, userName) as user\n| count as eventCount by eventTime, eventName, eventType, type, user, awsRegion, sourceIPAddress, eventStatus, accountId, requestID, errorCode, errorMessage\n| sort by eventTime"
        query_type   = "Logs"
      }

      title           = "Receipt Event Details"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelf68b7d6aa80b9941"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" *Domain*\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventname matches \"*Domain*\"\n| if (isEmpty(userName), user, userName) as user\n| count as eventCount by eventname\n| sort by eventCount, eventname asc"
        query_type   = "Logs"
      }

      title           = "Domain Events"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":\"10\",\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\"},\"series\":{}}"
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

  title = "Amazon SES - CloudTrail Events by Event Name"
}

resource "sumologic_dashboard" "amazon_ses_cloud_trail_events_overview" {
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
        key       = "panel05460a46bac31b49"
        structure = "{\"width\":18,\"height\":6,\"x\":6,\"y\":16}"
      }

      layout_structure {
        key       = "panel1ee5a504901da94e"
        structure = "{\"width\":6,\"height\":6,\"x\":0,\"y\":11}"
      }

      layout_structure {
        key       = "panel282dcbf588eb3b49"
        structure = "{\"width\":18,\"height\":6,\"x\":6,\"y\":11}"
      }

      layout_structure {
        key       = "panel4ea01091ad4eca4b"
        structure = "{\"width\":5,\"height\":6,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panel64e3e63f89021945"
        structure = "{\"width\":6,\"height\":6,\"x\":0,\"y\":16}"
      }

      layout_structure {
        key       = "panel7f5584f69b980841"
        structure = "{\"width\":24,\"height\":6,\"x\":0,\"y\":28}"
      }

      layout_structure {
        key       = "panel9dcab67d9cc6b94d"
        structure = "{\"width\":12,\"height\":6,\"x\":12,\"y\":6}"
      }

      layout_structure {
        key       = "panela387dfd399012b41"
        structure = "{\"width\":12,\"height\":8,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panelc4cfc417ace76841"
        structure = "{\"width\":16,\"height\":9,\"x\":8,\"y\":21}"
      }

      layout_structure {
        key       = "paneld1ced73c9cb05841"
        structure = "{\"width\":8,\"height\":9,\"x\":0,\"y\":21}"
      }

      layout_structure {
        key       = "panelf17735658154c944"
        structure = "{\"width\":7,\"height\":6,\"x\":5,\"y\":6}"
      }

      layout_structure {
        key       = "panelfa13992fbe5c7b4a"
        structure = "{\"width\":12,\"height\":8,\"x\":0,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel05460a46bac31b49"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" !errorCode\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventStatus=\"Success\"\n| if (isEmpty(userName), user, userName) as user\n| timeslice 1s\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count as eventCount by _timeslice, eventName, awsRegion, sourceIPAddress, accountId, user, type, requestId, userAgent\n| sort by _timeslice"
        query_type   = "Logs"
      }

      title           = "Successful Event Details"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel1ee5a504901da94e"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" errorCode\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventStatus=\"Failure\"\n| if (isEmpty(userName), user, userName) as user\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count as eventCount by eventName\n| sort by eventCount"
        query_type   = "Logs"
      }

      title           = "Failed Events"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":\"10\",\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel282dcbf588eb3b49"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" errorCode\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventStatus=\"Failure\"\n| if (isEmpty(userName), user, userName) as user\n| timeslice 1s\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count as eventCount by _timeslice, eventName, errorCode, errorMessage, awsRegion, sourceIPAddress, accountId, user, type, requestID\n| sort by _timeslice"
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
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count by eventStatus"
        query_type   = "Logs"
      }

      title           = "Event Status"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":\"10\",\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel64e3e63f89021945"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" !errorCode\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventStatus=\"Success\"\n| if (isEmpty(userName), user, userName) as user\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count as eventCount by eventName\n| sort by eventCount"
        query_type   = "Logs"
      }

      title           = "Successful Events"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"pie\",\"displayType\":\"default\",\"fillOpacity\":1,\"startAngle\":270,\"innerRadius\":\"30%\",\"maxNumOfSlices\":\"10\",\"mode\":\"distribution\"},\"color\":{\"family\":\"Categorical Default\"},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\"},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel7f5584f69b980841"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(userName), user, userName) as user\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus \n| timeslice 1h\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count as eventCount by _timeslice, eventName\n| transpose row _timeslice column eventName"
        query_type   = "Logs"
      }

      title           = "Events Trend by Event Name"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"column\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel9dcab67d9cc6b94d"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| timeslice 1d\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count by _timeslice, eventStatus\n| fillmissing timeslice(1d), values (\"Success\", \"Failure\") in eventStatus\n| transpose row _timeslice column eventStatus"
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
      key                                         = "panela387dfd399012b41"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventSource\\\":\\\"ses.amazonaws.com\\\"\" errorCode\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventStatus=\"Failure\"\n| if (isEmpty(userName), user, userName) as user\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count by sourceIPAddress, eventName\n| lookup latitude, longitude, country_code, country_name, region, city, postal_code from geo://location on ip = sourceIPAddress\n| sort _count"
        query_type   = "Logs"
      }

      title           = "Failure Events Location"
      visual_settings = "{\"general\":{\"mode\":\"map\",\"type\":\"map\"},\"map\":{\"mainMetric\":{}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelc4cfc417ace76841"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| timeslice 1d\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count as eventCount by user, eventName\n| transpose row user column eventName"
        query_type   = "Logs"
      }

      title           = "Events by User"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"bar\",\"displayType\":\"stacked\",\"fillOpacity\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"series\":{},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "paneld1ced73c9cb05841"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count as eventCount by type, user\n| top 10 type, user by eventCount"
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
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\" errorCode\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventStatus=\"Failure\"\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count as eventCount by errorCode \n| top 10 errorCode by eventCount"
        query_type   = "Logs"
      }

      title           = "Top Error Codes"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelfa13992fbe5c7b4a"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventSource\\\":\\\"ses.amazonaws.com\\\"\" !errorCode\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop  \n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| where eventSource=\"ses.amazonaws.com\" and eventStatus=\"Success\"\n| if (isEmpty(userName), user, userName) as user\n|where eventname matches \"{{eventname}}\" AND awsregion matches \"{{awsregion}}\" AND accountid matches \"{{accountid}}\"\n|count by sourceIPAddress, eventName\n| lookup latitude, longitude, country_code, country_name, region, city, postal_code from geo://location on ip = sourceIPAddress\n| sort _count"
        query_type   = "Logs"
      }

      title           = "Successful Events Location"
      visual_settings = "{\"title\":{\"fontSize\":14},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"table\",\"displayType\":\"default\",\"paginationPageSize\":100,\"fontSize\":12,\"mode\":\"distribution\"}}"
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

  title = "Amazon SES - CloudTrail Events Overview"

  variable {
    allow_multi_select = "false"
    display_name       = "accountid"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "accountid"

    source_definition {
      log_query_variable_source_definition {
        field = "accountid"
        query = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| timeslice 1d"
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
        query = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| timeslice 1d"
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
        query = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| timeslice 1d"
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
        query = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  \"\\\"eventsource\\\":\\\"ses.amazonaws.com\\\"\"\n| json \"eventTime\" nodrop | json \"eventSource\" nodrop | json \"eventName\" nodrop | json \"awsRegion\" nodrop | json \"sourceIPAddress\" nodrop | json \"eventType\" nodrop | json \"errorCode\" nodrop | json \"errorMessage\" nodrop | json \"userAgent\" nodrop | json \"requestID\" nodrop | json \"userIdentity.accountId\" as accountId nodrop | json \"userIdentity.arn\" as arn nodrop | parse field=arn \":assumed-role/*\" as user nodrop | parse field=arn \"arn:aws:iam::*:*\" as accountId, user nodrop | json \"userIdentity.userName\" as username nodrop | json \"userIdentity.type\" as type nodrop\n| where eventSource=\"ses.amazonaws.com\"\n| if (isEmpty(errorCode), \"Success\", \"Failure\") as eventStatus\n| if (isEmpty(userName), user, userName) as user\n| timeslice 1d"
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
        structure = "{\"width\":24,\"height\":1,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panel230691659ced8848"
        structure = "{\"width\":6,\"height\":6,\"x\":0,\"y\":1}"
      }

      layout_structure {
        key       = "panel46f7d6c7872dea49"
        structure = "{\"width\":6,\"height\":6,\"x\":18,\"y\":1}"
      }

      layout_structure {
        key       = "panel5a1e59cb90d2b848"
        structure = "{\"width\":6,\"height\":6,\"x\":12,\"y\":1}"
      }

      layout_structure {
        key       = "panel9d7350fe8aa66a48"
        structure = "{\"width\":6,\"height\":6,\"x\":6,\"y\":1}"
      }

      layout_structure {
        key       = "panela0bcbaddaa39894b"
        structure = "{\"width\":12,\"height\":10,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panelae789435b40e0b4d"
        structure = "{\"width\":6,\"height\":5,\"x\":12,\"y\":6}"
      }

      layout_structure {
        key       = "panelc299821ea42e7848"
        structure = "{\"width\":6,\"height\":5,\"x\":12,\"y\":10}"
      }

      layout_structure {
        key       = "paneldd502e4a9688f940"
        structure = "{\"width\":6,\"height\":5,\"x\":18,\"y\":6}"
      }

      layout_structure {
        key       = "panelf8656e7b8f120943"
        structure = "{\"width\":6,\"height\":5,\"x\":18,\"y\":10}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel230691659ced8848"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop \n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\"\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" AND useragent matches \"{{useragent}}\" AND name matches \"{{name}}\" AND source matches \"{{source}}\" AND sourceip matches \"{{sourceip}}\"\n|count as eventCount by ComplaintemailAddress\n| sort by eventCount, ComplaintemailAddress\n| limit 10"
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
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop \n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| if (isEmpty(complaintFeedbackType), \"InformationNotAvailable\", complaintFeedbackType) as complaintFeedbackType\n| where notificationType=\"Complaint\"\n| timeslice 15m\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" AND useragent matches \"{{useragent}}\" AND name matches \"{{name}}\" AND source matches \"{{source}}\" AND sourceip matches \"{{sourceip}}\"\n|count by _timeslice, complaintFeedbackType \n| transpose row _timeslice column complaintFeedbackType"
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
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\" userAgent\n| json \"notificationType\", \"mail\" nodrop \n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\" and !isEmpty(userAgent)\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" AND useragent matches \"{{useragent}}\" AND name matches \"{{name}}\" AND source matches \"{{source}}\" AND sourceip matches \"{{sourceip}}\"\n|count as eventCount by userAgent\n| sort by eventCount, userAgent asc\n| limit 10"
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
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop \n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\"\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" AND useragent matches \"{{useragent}}\" AND name matches \"{{name}}\" AND source matches \"{{source}}\" AND sourceip matches \"{{sourceip}}\"\n|count as eventCount by domain\n| sort by eventCount, domain asc\n| limit 10"
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
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\" source\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\"\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" AND useragent matches \"{{useragent}}\" AND name matches \"{{name}}\" AND source matches \"{{source}}\" AND sourceip matches \"{{sourceip}}\"\n|count as eventCount by source\n| top 10 source by eventCount, source asc"
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
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\"\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" AND useragent matches \"{{useragent}}\" AND name matches \"{{name}}\" AND source matches \"{{source}}\" AND sourceip matches \"{{sourceip}}\"\n|count as eventCount by sendingAccountId"
        query_type   = "Logs"
      }

      title           = "Sending AccountId"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelc299821ea42e7848"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\"\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" AND useragent matches \"{{useragent}}\" AND name matches \"{{name}}\" AND source matches \"{{source}}\" AND sourceip matches \"{{sourceip}}\"\n|count as eventCount by sourceIp\n| sort by eventCount, sourceIp"
        query_type   = "Logs"
      }

      title           = "Sending SourceIP"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "paneldd502e4a9688f940"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\"\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" AND useragent matches \"{{useragent}}\" AND name matches \"{{name}}\" AND source matches \"{{source}}\" AND sourceip matches \"{{sourceip}}\"\n|count as eventCount by awsRegion\n| sort by eventCount, awsRegion asc"
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
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\"\n|where sendingaccountid matches \"{{sendingaccountid}}\" AND awsregion matches \"{{awsregion}}\" AND complaintemailaddress matches \"{{complaintemailaddress}}\" AND domain matches \"{{domain}}\" AND complaintfeedbacktype matches \"{{complaintfeedbacktype}}\" AND useragent matches \"{{useragent}}\" AND name matches \"{{name}}\" AND source matches \"{{source}}\" AND sourceip matches \"{{sourceip}}\"\n|count as eventCount by identity\n| sort by eventCount, identity asc"
        query_type   = "Logs"
      }

      title           = "Sending Identity"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Complaint\\\"\"\n| json \"notificationType\", \"mail\" nodrop\n| json \"complaint.complainedRecipients\" as complainedRecipients nodrop\n| json \"complaint.complaintFeedbackType\" as complaintFeedbackType nodrop\n| parse regex field=complainedRecipients  \"\\\"emailAddress\\\":\\\"(?<ComplaintemailAddress>[^\\\"]+)\\\"\" multi\n| parse field=ComplaintemailAddress \"*@*\" as name, domain\n| json \"complaint.userAgent\" as userAgent nodrop\n| json field=mail \"sourceArn\" nodrop | json field=mail \"sendingAccountId\" nodrop | json field=mail \"sourceIp\" nodrop | json field=mail \"destination\" nodrop | json field=mail \"source\" nodrop\n| parse regex field=sourceArn \"arn:aws:ses:(?<awsRegion>[^:]+):\\d+:identity/(?<identity>.*)\"\n| where notificationType=\"Complaint\""
      }
    }
  }
}

resource "sumologic_dashboard" "amazon_ses_delivered_notifications" {
  description = "See details of delivered notifications including the email destinations, domains, reporting MTA, and delivery processing time."
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
        key       = "panel021b9622b4ff7b43"
        structure = "{\"width\":7,\"height\":9,\"x\":6,\"y\":1}"
      }

      layout_structure {
        key       = "panel0ac6de4ebe34d948"
        structure = "{\"width\":11,\"height\":9,\"x\":13,\"y\":1}"
      }

      layout_structure {
        key       = "panel450d269f90e9b849"
        structure = "{\"width\":24,\"height\":1,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panel542223d49db5094d"
        structure = "{\"width\":6,\"height\":9,\"x\":0,\"y\":1}"
      }

      layout_structure {
        key       = "panel791c8cdcb58afa4c"
        structure = "{\"width\":11,\"height\":10,\"x\":13,\"y\":8}"
      }

      layout_structure {
        key       = "panel9d6d34fdbfeebb41"
        structure = "{\"width\":7,\"height\":10,\"x\":6,\"y\":8}"
      }

      layout_structure {
        key       = "panelb29f2f4bb8143848"
        structure = "{\"width\":6,\"height\":10,\"x\":0,\"y\":8}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel021b9622b4ff7b43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Delivery\\\"\"\n| json \"notificationType\" nodrop | json \"mail.destination\" as mailDestination nodrop | parse field=mailDestination \"[*]\" as deliveredemailAddressSet nodrop\n| parse regex field=deliveredemailAddressSet \"\\\"(?<deliveredemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=deliveredemailAddress \"*@*\" as name, domain nodrop\n| json \"delivery.processingTimeMillis\" as deliveryProcessingTimeMillis nodrop | json \"delivery.remoteMtaIp\" as remoteMtaIP nodrop | json \"delivery.reportingMTA\" as reportingMTA nodrop\n| where notificationType=\"Delivery\"\n|where remotemtaip matches \"{{remotemtaip}}\" AND deliveredemailaddress matches \"{{deliveredemailaddress}}\" AND domain matches \"{{domain}}\" AND reportingmta matches \"{{reportingmta}}\"\n|count as eventCount by domain\n| sort by eventCount, domain\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Top Delivered email Domains"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel0ac6de4ebe34d948"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Delivery\\\"\"\n| json \"notificationType\" nodrop | json \"mail.destination\" as mailDestination nodrop | parse field=mailDestination \"[*]\" as deliveredemailAddressSet nodrop\n| parse regex field=deliveredemailAddressSet \"\\\"(?<deliveredemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=deliveredemailAddress \"*@*\" as name, domain nodrop\n| json \"delivery.processingTimeMillis\" as deliveryProcessingTimeMillis nodrop | json \"delivery.remoteMtaIp\" as remoteMtaIP nodrop | json \"delivery.reportingMTA\" as reportingMTA nodrop\n| where notificationType=\"Delivery\"\n| timeslice 1h\n|where remotemtaip matches \"{{remotemtaip}}\" AND deliveredemailaddress matches \"{{deliveredemailaddress}}\" AND domain matches \"{{domain}}\" AND reportingmta matches \"{{reportingmta}}\"\n|count by _timeslice, deliveredemailAddress \n| count(deliveredemailAddress) as deliveredemailAddresses by _timeslice"
        query_type   = "Logs"
      }

      title           = "Delivery Trend"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"area\",\"displayType\":\"default\",\"markerSize\":null,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"fillOpacity\":0.25,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel542223d49db5094d"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Delivery\\\"\"\n| json \"notificationType\" nodrop | json \"mail.destination\" as mailDestination nodrop | parse field=mailDestination \"[*]\" as deliveredemailAddressSet nodrop\n| parse regex field=deliveredemailAddressSet \"\\\"(?<deliveredemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=deliveredemailAddress \"*@*\" as name, domain nodrop\n| json \"delivery.processingTimeMillis\" as deliveryProcessingTimeMillis nodrop | json \"delivery.remoteMtaIp\" as remoteMtaIP nodrop | json \"delivery.reportingMTA\" as reportingMTA nodrop\n| where notificationType=\"Delivery\"\n|where remotemtaip matches \"{{remotemtaip}}\" AND deliveredemailaddress matches \"{{deliveredemailaddress}}\" AND domain matches \"{{domain}}\" AND reportingmta matches \"{{reportingmta}}\"\n|count as eventCount by deliveredemailAddress\n| sort by eventCount, deliveredemailAddress\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Top Delivered email destinations"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel791c8cdcb58afa4c"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  \"\\\"notificationType\\\":\\\"Delivery\\\"\"\n| json \"notificationType\" nodrop | json \"mail.destination\" as mailDestination nodrop | parse field=mailDestination \"[*]\" as deliveredemailAddressSet nodrop\n| parse regex field=deliveredemailAddressSet \"\\\"(?<deliveredemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=deliveredemailAddress \"*@*\" as name, domain nodrop\n| json \"delivery.processingTimeMillis\" as deliveryProcessingTimeMillis nodrop | json \"delivery.remoteMtaIp\" as remoteMtaIP nodrop | json \"delivery.reportingMTA\" as reportingMTA nodrop\n| where notificationType=\"Delivery\"\n| timeslice 5m\n|where remotemtaip matches \"{{remotemtaip}}\" AND deliveredemailaddress matches \"{{deliveredemailaddress}}\" AND domain matches \"{{domain}}\" AND reportingmta matches \"{{reportingmta}}\"\n|avg (deliveryProcessingTimeMillis) as AveragedeliveryProcessingTimeMillis by _timeslice\n| outlier AveragedeliveryProcessingTimeMillis"
        query_type   = "Logs"
      }

      title           = "Delivery Processing Time Outlier"
      visual_settings = "{\"title\":{\"fontSize\":14},\"general\":{\"type\":\"line\",\"displayType\":\"default\",\"markerSize\":null,\"lineDashType\":\"solid\",\"markerType\":\"none\",\"lineThickness\":1,\"mode\":\"timeSeries\"},\"axes\":{\"axisX\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"hideLabels\":false,\"title\":\"\",\"titleFontSize\":12,\"labelFontSize\":12,\"logarithmic\":false,\"gridColor\":\"\",\"minimum\":null,\"maximum\":null}},\"legend\":{\"enabled\":false,\"verticalAlign\":\"right\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"color\":{\"family\":\"Categorical Default\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}},\"overrides\":[],\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel9d6d34fdbfeebb41"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Delivery\\\"\"\n| json \"notificationType\" nodrop | json \"mail.destination\" as mailDestination nodrop | parse field=mailDestination \"[*]\" as deliveredemailAddressSet nodrop\n| parse regex field=deliveredemailAddressSet \"\\\"(?<deliveredemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=deliveredemailAddress \"*@*\" as name, domain nodrop\n| json \"delivery.processingTimeMillis\" as deliveryProcessingTimeMillis nodrop | json \"delivery.remoteMtaIp\" as remoteMtaIP nodrop | json \"delivery.reportingMTA\" as reportingMTA nodrop\n| where notificationType=\"Delivery\"\n|where remotemtaip matches \"{{remotemtaip}}\" AND deliveredemailaddress matches \"{{deliveredemailaddress}}\" AND domain matches \"{{domain}}\" AND reportingmta matches \"{{reportingmta}}\"\n|count as eventCount by remoteMtaIP\n| lookup latitude, longitude, country_name, region, city from geo://location on ip=remoteMtaIP\n| count by latitude, longitude, country_name, region, city"
        query_type   = "Logs"
      }

      title           = "Reporting MTA IP Location"
      visual_settings = "{\"general\":{\"mode\":\"map\",\"type\":\"map\"},\"map\":{\"mainMetric\":{}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelb29f2f4bb8143848"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Delivery\\\"\"\n| json \"notificationType\" nodrop | json \"mail.destination\" as mailDestination nodrop | parse field=mailDestination \"[*]\" as deliveredemailAddressSet nodrop\n| parse regex field=deliveredemailAddressSet \"\\\"(?<deliveredemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=deliveredemailAddress \"*@*\" as name, domain nodrop\n| json \"delivery.processingTimeMillis\" as deliveryProcessingTimeMillis nodrop | json \"delivery.remoteMtaIp\" as remoteMtaIP nodrop | json \"delivery.reportingMTA\" as reportingMTA nodrop\n| where notificationType=\"Delivery\"\n|where remotemtaip matches \"{{remotemtaip}}\" AND deliveredemailaddress matches \"{{deliveredemailaddress}}\" AND domain matches \"{{domain}}\" AND reportingmta matches \"{{reportingmta}}\"\n|count as eventCount by reportingMTA\n| sort by eventCount, reportingMTA\n| limit 10"
        query_type   = "Logs"
      }

      title           = "Top Reporting MTA"
      visual_settings = "{\"title\":{\"fontSize\":12},\"series\":{},\"general\":{\"type\":\"table\",\"fontSize\":12,\"mode\":\"timeSeries\"},\"thresholdsSettings\":{\"fillRemainingGreen\":false,\"showThresholds\":false,\"thresholds\":{\"warning\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":80},\"critical\":{\"display\":true,\"comparator\":\"greater_or_equal\",\"value\":100}}}}"
    }
  }

  panel {
    text_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel450d269f90e9b849"
      title                                       = "Delivered Notifications"
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

  title = "Amazon SES - Delivered Notifications"

  variable {
    allow_multi_select = "false"
    display_name       = "deliveredemailaddress"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "deliveredemailaddress"

    source_definition {
      log_query_variable_source_definition {
        field = "deliveredemailaddress"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Delivery\\\"\"\n| json \"notificationType\" nodrop | json \"mail.destination\" as mailDestination nodrop | parse field=mailDestination \"[*]\" as deliveredemailAddressSet nodrop\n| parse regex field=deliveredemailAddressSet \"\\\"(?<deliveredemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=deliveredemailAddress \"*@*\" as name, domain nodrop\n| json \"delivery.processingTimeMillis\" as deliveryProcessingTimeMillis nodrop | json \"delivery.remoteMtaIp\" as remoteMtaIP nodrop | json \"delivery.reportingMTA\" as reportingMTA nodrop\n| where notificationType=\"Delivery\""
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Delivery\\\"\"\n| json \"notificationType\" nodrop | json \"mail.destination\" as mailDestination nodrop | parse field=mailDestination \"[*]\" as deliveredemailAddressSet nodrop\n| parse regex field=deliveredemailAddressSet \"\\\"(?<deliveredemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=deliveredemailAddress \"*@*\" as name, domain nodrop\n| json \"delivery.processingTimeMillis\" as deliveryProcessingTimeMillis nodrop | json \"delivery.remoteMtaIp\" as remoteMtaIP nodrop | json \"delivery.reportingMTA\" as reportingMTA nodrop\n| where notificationType=\"Delivery\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "remotemtaip"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "remotemtaip"

    source_definition {
      log_query_variable_source_definition {
        field = "remotemtaip"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Delivery\\\"\"\n| json \"notificationType\" nodrop | json \"mail.destination\" as mailDestination nodrop | parse field=mailDestination \"[*]\" as deliveredemailAddressSet nodrop\n| parse regex field=deliveredemailAddressSet \"\\\"(?<deliveredemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=deliveredemailAddress \"*@*\" as name, domain nodrop\n| json \"delivery.processingTimeMillis\" as deliveryProcessingTimeMillis nodrop | json \"delivery.remoteMtaIp\" as remoteMtaIP nodrop | json \"delivery.reportingMTA\" as reportingMTA nodrop\n| where notificationType=\"Delivery\""
      }
    }
  }

  variable {
    allow_multi_select = "false"
    display_name       = "reportingmta"
    hide_from_ui       = "false"
    include_all_option = "true"
    name               = "reportingmta"

    source_definition {
      log_query_variable_source_definition {
        field = "reportingmta"
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   \"\\\"notificationType\\\":\\\"Delivery\\\"\"\n| json \"notificationType\" nodrop | json \"mail.destination\" as mailDestination nodrop | parse field=mailDestination \"[*]\" as deliveredemailAddressSet nodrop\n| parse regex field=deliveredemailAddressSet \"\\\"(?<deliveredemailAddress>[^\\\"]*)\\\"\" multi\n| parse field=deliveredemailAddress \"*@*\" as name, domain nodrop\n| json \"delivery.processingTimeMillis\" as deliveryProcessingTimeMillis nodrop | json \"delivery.remoteMtaIp\" as remoteMtaIP nodrop | json \"delivery.reportingMTA\" as reportingMTA nodrop\n| where notificationType=\"Delivery\""
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
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  mail source\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop\n|where mailsourceip matches \"{{mailsourceip}}\" AND mailsendingaccountid matches \"{{mailsendingaccountid}}\" AND mailsource matches \"{{mailsource}}\" AND notificationtype matches \"{{notificationtype}}\"\n|count as eventCount by mailSource | where !isBlank(mailSource)\n| sort by eventCount, mailSource\n| limit 10"
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
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  mail sourceIp\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop\n|where mailsourceip matches \"{{mailsourceip}}\" AND mailsendingaccountid matches \"{{mailsendingaccountid}}\" AND mailsource matches \"{{mailsource}}\" AND notificationtype matches \"{{notificationtype}}\"\n|count as eventCount by mailSourceIP\n| where !isBlank(mailSourceIP)\n| lookup latitude, longitude, country_name, region, city from geo://location on ip=mailSourceIP\n| count by latitude, longitude, country_name, region, city"
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
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  notificationType\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop\n|where mailsourceip matches \"{{mailsourceip}}\" AND mailsendingaccountid matches \"{{mailsendingaccountid}}\" AND mailsource matches \"{{mailsource}}\" AND notificationtype matches \"{{notificationtype}}\"\n|count as eventCount by notificationType | where !isBlank(notificationType)\n| sort by eventCount"
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
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  mail sendingAccountId\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop\n|where mailsourceip matches \"{{mailsourceip}}\" AND mailsendingaccountid matches \"{{mailsendingaccountid}}\" AND mailsource matches \"{{mailsource}}\" AND notificationtype matches \"{{notificationtype}}\"\n|count as eventCount by mailSendingAccountId | where !isBlank(mailSendingAccountId)\n| sort by eventCount, mailSendingAccountId\n| limit 10"
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
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  notificationType\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop\n| where !isBlank(notificationType)\n| timeslice 15m\n|where mailsourceip matches \"{{mailsourceip}}\" AND mailsendingaccountid matches \"{{mailsendingaccountid}}\" AND mailsource matches \"{{mailsource}}\" AND notificationtype matches \"{{notificationtype}}\"\n|count by _timeslice, NotificationType\n| transpose row _timeslice column NotificationType"
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  mail source\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop"
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  mail source\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop"
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  mail source\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop"
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
        query = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  mail source\n| json \"notificationType\" nodrop | json \"mail.source\" as mailSource nodrop | json \"mail.sourceIp\" as mailSourceIP nodrop | json \"mail.sendingAccountId\" as mailSendingAccountId nodrop"
      }
    }
  }
}
