# Rack's parser limits are a defense-in-depth layer against oversized query
# strings and form bodies that can consume excessive CPU and memory.
Rack::Utils.param_depth_limit = ENV.fetch('RACK_PARAM_DEPTH_LIMIT', 32).to_i
Rack::Utils.default_query_parser = Rack::QueryParser.make_default(
  Rack::Utils.param_depth_limit,
  bytesize_limit: ENV.fetch('RACK_QUERY_PARSER_BYTESIZE_LIMIT', 1_048_576).to_i,
  params_limit: ENV.fetch('RACK_QUERY_PARSER_PARAMS_LIMIT', 1_024).to_i
)
Rack::Utils.multipart_total_part_limit = ENV.fetch('RACK_MULTIPART_TOTAL_PART_LIMIT', 1_024).to_i
