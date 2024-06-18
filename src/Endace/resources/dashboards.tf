resource "sumologic_dashboard" "cisco_asa" {
  folder_id = sumologic_folder.integration_folder.id

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
        key       = "panel2779E6D9B279EA41"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panel4BABEE418B37DA4C"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":6}"
      }

      layout_structure {
        key       = "panel6E6AF68587342A44"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelBD7B1CE3A4C40B44"
        structure = "{\"height\":18,\"width\":24,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panelD0E4754B8434AA43"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":6}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel2779E6D9B279EA41"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | where source = \"ciscoasa\" | parse regex \"Protocol: (?<Protocol>\\w{1,3})\" | count by Protocol | limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Protocols"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel4BABEE418B37DA4C"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | where source = \"ciscoasa\" | keyvalue regex \"\\s(.*?): (.*?),\" keys \"Classification\" as Classification | count by Classification | sort by _count | limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Attacks"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel6E6AF68587342A44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | where source = \"ciscoasa\" | count by src_ip | sort by _count | limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Source IPs"
      visual_settings = "{\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"distribution\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelBD7B1CE3A4C40B44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | where source = \"ciscoasa\" |keyvalue regex \"\\s(.*?): (.*?),\" keys \"Classification\" as Classification | keyvalue regex \"\\s(.*?): (.*?),\" keys \"Message\" as message| count by  _messagetime, endace_pivot_to_vision, log, message, Classification, src_ip, dest_ip"
        query_type   = "Logs"
      }

      title           = "Endace_Pivot_to_Vision"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelD0E4754B8434AA43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | where source = \"ciscoasa\" | parse regex \"ApplicationProtocol: (?<ApplicationProtocol>\\w{1,25})\" | count by ApplicationProtocol | limit 20"
        query_type   = "Logs"
      }

      title           = "Top 10 Application Protocols"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{}}"
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

  title = "Endace - Cisco ASA"
}

resource "sumologic_dashboard" "cisco_firepower" {
  folder_id = sumologic_folder.integration_folder.id

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
        key       = "panel52026881B93D9B4F"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":6}"
      }

      layout_structure {
        key       = "panel756C8E3EB24E5946"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panel8ABF4460B1C54B44"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":6}"
      }

      layout_structure {
        key       = "panel978D9AD088C8194D"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panelB77994F09044184C"
        structure = "{\"height\":21,\"width\":24,\"x\":0,\"y\":12}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel52026881B93D9B4F"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )\n| where source = \"FTD-1-430001\" | parse regex \"ApplicationProtocol: (?<ApplicationProtocol>\\w{1,25})\" | count by ApplicationProtocol | limit 20"
        query_type   = "Logs"
      }

      title           = "Top Application Protocols"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel756C8E3EB24E5946"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )\n| where source = \"FTD-1-430001\" | count by src_ip | sort by _count | limit 10 "
        query_type   = "Logs"
      }

      title           = "Top 10 Source IPs"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"column\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel8ABF4460B1C54B44"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )\n| where source = \"FTD-1-430001\" | keyvalue regex \"\\s(.*?): (.*?),\" keys \"Classification\" as Classification | count by Classification | sort by _count | limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Attacks"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel978D9AD088C8194D"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )\n| where source = \"FTD-1-430001\" | parse regex \"Protocol: (?<Protocol>\\w{1,10})\" | count by Protocol | limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Protocols"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB77994F09044184C"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )\n| where source = \"FTD-1-430001\" |keyvalue regex \"\\s(.*?): (.*?),\" keys \"Classification\" as Classification | keyvalue regex \"\\s(.*?): (.*?),\" keys \"Message\" as message| count by _messagetime, endace_pivot_to_vision, log, message, Classification, src_ip, dest_ip"
        query_type   = "Logs"
      }

      title           = "Endace_Pivot_to_Vision"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{}}"
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

  title = "Endace - Cisco Firepower"
}

resource "sumologic_dashboard" "palo_alto_networks" {
  folder_id = sumologic_folder.integration_folder.id

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
        key       = "panel5CB17C46A6A3CB43"
        structure = "{\"height\":8,\"width\":12,\"x\":12,\"y\":10}"
      }

      layout_structure {
        key       = "panel899A6B8BB74A8A4F"
        structure = "{\"height\":10,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panelB19787FE96FB7B43"
        structure = "{\"height\":10,\"width\":12,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panelB8C05C759C7C7B49"
        structure = "{\"height\":8,\"width\":12,\"x\":0,\"y\":10}"
      }

      layout_structure {
        key       = "panelE6B679CD9BDDD841"
        structure = "{\"height\":23,\"width\":24,\"x\":0,\"y\":18}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel5CB17C46A6A3CB43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | where source = \"Palo Alto Networks\" |keyvalue regex \"=(.*?) \" \"protocol\" | count by protocol | sort by _count | limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Protocols"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel899A6B8BB74A8A4F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | where source = \"Palo Alto Networks\" |  split log delim='|' extract 5 as Threat | count by Threat | sort by _count | limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Threats"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB19787FE96FB7B43"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | where source = \"Palo Alto Networks\" | count by src_ip | sort by _count | limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Source IPs"
      visual_settings = "{\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"distribution\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB8C05C759C7C7B49"

      query {
        query_key    = "A"
        query_string = "${var.scope_key}={{${var.scope_key_variable_display_name}}}  | where source = \"Palo Alto Networks\" | keyvalue regex \"=(.*?) \" \"app\" | count by app | sort by _count | limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Apps"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelE6B679CD9BDDD841"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key}={{${var.scope_key_variable_display_name}}} )\n| where source = \"Palo Alto Networks\" | split log delim='|' extract 5 as Threat | keyvalue regex \"=(.*?) \" \"app\" | count by _messagetime, endace_pivot_to_vision, log, Threat, app, src_ip, dest_ip"
        query_type   = "Logs"
      }

      title           = "Endace_Pivot_to_Vision"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{}}"
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

  title = "Endace - Palo Alto Networks"
}

resource "sumologic_dashboard" "suricata" {
  folder_id = sumologic_folder.integration_folder.id

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
        key       = "panel2DB3B4DF90486949"
        structure = "{\"height\":23,\"width\":24,\"x\":0,\"y\":12}"
      }

      layout_structure {
        key       = "panel34E577A187428840"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":0}"
      }

      layout_structure {
        key       = "panel4306B099BB698843"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":0}"
      }

      layout_structure {
        key       = "panel5C0A261CB8A74942"
        structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":6,\"minHeight\":3,\"minWidth\":3}"
      }

      layout_structure {
        key       = "panel97DD35C7918A784B"
        structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":6}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel2DB3B4DF90486949"

      query {
        query_key    = "A"
        query_string = "(${var.scope_key1}={{${var.scope_key1_variable_display_name}}} )\n | count by _messagetime, endace_pivot_to_vision, log, src_ip, dest_ip "
        query_type   = "Logs"
      }

      title           = "Endace_Pivot_to_Vision"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel34E577A187428840"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  | count by src_ip | sort by _count | limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Source IPs"
      visual_settings = "{\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"distribution\"},\"overrides\":[]}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel4306B099BB698843"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  |parse regex \"proto.....(?<proto>\\w{1,10})\" | count by proto | sort by _count | limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Protocols"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel5C0A261CB8A74942"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  |parse regex \"event_type.....(?<event_type>\\w{1,10})\" | count by event_type | sort by _count | limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Event Types"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel97DD35C7918A784B"

      query {
        query_key    = "A"
        query_string = "${var.scope_key1}={{${var.scope_key1_variable_display_name}}}  |parse regex \"dest_port...(?<dest_port>\\d{1,10})\" | count by dest_port | sort by _count | limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Destination Ports"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}}}"
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

  title = "Endace - Suricata"
}

resource "sumologic_dashboard" "zeek" {
  folder_id = sumologic_folder.integration_folder.id

  variable {
    allow_multi_select = "false"
    default_value      = var.default_scope_value2
    display_name = var.scope_key2_variable_display_name
    hide_from_ui       = "false"
    include_all_option = "true"
    name = var.scope_key2_variable_display_name
    source_definition {
      csv_variable_source_definition {
        values = "${var.default_scope_value2}"
      }
    }
  }

  layout {
    grid {
      layout_structure {
        key       = "panel7496670086C6B943"
        structure = "{\"height\":7,\"width\":12,\"x\":11,\"y\":9}"
      }

      layout_structure {
        key       = "panel84EA31C4B669794F"
        structure = "{\"height\":34,\"width\":24,\"x\":0,\"y\":16}"
      }

      layout_structure {
        key       = "panelB7AF51999944EA44"
        structure = "{\"height\":9,\"width\":12,\"x\":11,\"y\":0}"
      }

      layout_structure {
        key       = "panelCFAF0923BF7AE843"
        structure = "{\"height\":7,\"width\":11,\"x\":0,\"y\":9}"
      }

      layout_structure {
        key       = "panelPANE-D852FB3FA91A8941"
        structure = "{\"height\":9,\"width\":11,\"x\":0,\"y\":0}"
      }
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel7496670086C6B943"

      query {
        query_key    = "A"
        query_string = "((${var.scope_key2}={{${var.scope_key2_variable_display_name}}} ))\n| split log delim='\t' extract 10 as smb_file\n| where %\"log.file.name\" = \"smb_files.log\"\n| count smb_file\n| sort by _count\n| limit 20"
        query_type   = "Logs"
      }

      title           = "Top 20 SMB Files"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"pie\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panel84EA31C4B669794F"

      query {
        query_key    = "A"
        query_string = "${var.scope_key2}={{${var.scope_key2_variable_display_name}}}  | split log delim='\t' extract 10 as smb_file, 9 as smb_location\n| where %\"log.file.name\" = \"smb_files.log\" | count by _messagetime, endace_pivot_to_vision, log, smb_file, smb_location, source_ip, dest_ip | limit 30"
        query_type   = "Logs"
      }

      title           = "Endace_Pivot_to_Vision"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"table\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}},\"series\":{}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelB7AF51999944EA44"

      query {
        query_key    = "A"
        query_string = "${var.scope_key2}={{${var.scope_key2_variable_display_name}}}  | count by dest_ip | sort by _count | limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Destination IPs"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"column\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelCFAF0923BF7AE843"

      query {
        query_key    = "A"
        query_string = "${var.scope_key2}={{${var.scope_key2_variable_display_name}}}  | parse regex field=_raw \"\\\\t(?<port>\\d{1,3})\\\\t-\" | count by port | limit 10"
        query_type   = "Logs"
      }

      title           = "Top ports used"
      visual_settings = "{\"general\":{\"mode\":\"distribution\",\"type\":\"column\",\"displayType\":\"default\"},\"version\":3,\"settings\":{\"table\":{\"version\":2,\"configuration\":{\"textTruncationMode\":\"none\",\"fontSize\":\"medium\",\"fontSizeOverride\":null,\"tableState\":null}},\"bar\":{\"chartType\":\"bar\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"column\":{\"chartType\":\"column\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"line\":{\"chartType\":\"line\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"area\":{\"chartType\":\"area\",\"version\":2,\"configuration\":{\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\",\"dimensions\":{\"width\":null,\"height\":null}},\"plotOptions\":{\"stacking\":null,\"lineToArea\":false},\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"},\"minorTickInterval\":null},\"yAxis\":[{\"title\":null,\"logScale\":false,\"min\":null,\"max\":null,\"bands\":null,\"minorTickInterval\":null}],\"seriesInfo\":{},\"showLineMarker\":true,\"lineMouseTracking\":true,\"multiSeriesTooltipOrder\":\"none\"}},\"pie\":{\"chartType\":\"pie\",\"version\":3,\"configuration\":{\"donutMode\":true,\"colors\":{\"index\":null,\"overrides\":null},\"legend\":{\"enabled\":true,\"position\":\"right\"},\"plotOptions\":{\"label\":{\"truncationMode\":\"middle\"},\"showSliceBorders\":true,\"maxNumOfPieSlices\":\"10\"}}},\"boxplot\":{\"chartType\":\"boxplot\",\"version\":1,\"configuration\":{\"xAxis\":{\"title\":null,\"label\":{\"truncationMode\":\"middle\"}},\"yAxis\":{\"title\":null,\"min\":null,\"max\":null}}},\"map\":{\"chartType\":\"map\",\"version\":1,\"configuration\":{\"maptype\":\"cluster\"}},\"svv\":{\"version\":2,\"configuration\":{\"colorOverride\":null,\"backgroundColorEnabled\":false,\"noDataBehavior\":{\"enabled\":false,\"color\":\"#cccccc\",\"value\":null,\"isString\":null},\"valueType\":{\"number\":{\"showNumber\":true,\"unit\":null,\"colorsByValueRange\":null},\"boolean\":{\"trueColor\":\"#6aa84f\",\"falseColor\":\"#cc0000\"}},\"labels\":{\"prefix\":{\"enabled\":false,\"text\":\"\",\"align\":\"left\"},\"postfix\":{\"enabled\":false,\"text\":\"\",\"align\":\"right\"}}}},\"sankey\":{\"version\":1,\"configuration\":{}},\"text\":{\"version\":1,\"configuration\":{\"text\":null}},\"metrics\":{\"version\":2,\"configuration\":{\"blockSettings\":{},\"viewType\":\"timeline\",\"zoom\":\"xy\",\"yAxis\":{\"defaults\":[{\"name\":\"\"},{\"name\":\"\"}],\"custom\":[{},{}]},\"xAxis\":{\"scrubber\":true},\"outliers\":{\"enabled\":true,\"top\":1,\"scope\":\"Chart\",\"cyclicality\":false,\"threshold\":7,\"autoShowBand\":true},\"colorFamily\":\"METRIC_DEFAULT\"}},\"common\":{\"version\":1,\"configuration\":{\"drilldown\":{\"fallback\":{\"target\":{\"id\":null,\"name\":null,\"enabled\":null}}}}}}}"
    }
  }

  panel {
    sumo_search_panel {
      keep_visual_settings_consistent_with_parent = "true"
      key                                         = "panelPANE-D852FB3FA91A8941"

      query {
        query_key    = "A"
        query_string = "${var.scope_key2}={{${var.scope_key2_variable_display_name}}} | count by source_ip | sort by _count | limit 10"
        query_type   = "Logs"
      }

      title           = "Top 10 Source IPs"
      visual_settings = "{\"title\":{\"fontSize\":14},\"legend\":{\"enabled\":true,\"verticalAlign\":\"bottom\",\"fontSize\":12,\"maxHeight\":50,\"showAsTable\":false,\"wrap\":true},\"axes\":{\"axisX\":{\"titleFontSize\":12,\"labelFontSize\":12},\"axisY\":{\"titleFontSize\":12,\"labelFontSize\":12}},\"series\":{},\"general\":{\"type\":\"column\",\"displayType\":\"default\",\"roundDataPoints\":true,\"fillOpacity\":1,\"mode\":\"distribution\"},\"overrides\":[]}"
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

  title = "Endace - Zeek"
}
