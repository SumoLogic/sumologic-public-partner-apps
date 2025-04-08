resource "sumologic_log_search" "example_query" {
  description         = "Example on how to query Phylum's threat feed for file hashes"
  name                = "example query"
  parent_id           = sumologic_folder.integration_folder.id
  parsing_mode        = "Manual"
  query_parameter {
    data_type   = "ANY"
    description = "Logs data source"
    name = var.scope_key_variable_display_name
    value = "${var.default_scope_value}"
  }

  query_string        = "${var.scope_key}={{${var.scope_key_variable_display_name}}}   |\nparse \"hash: *\" as candidate_hash\n| lookup * from ${var.lookup_table_path} on id=candidate_hash "
  run_by_receipt_time = "false"

  time_range {
    begin_bounded_time_range {
      from {
        relative_time_range {
          relative_time = "-17w1d"
        }
      }
    }
  }
}
