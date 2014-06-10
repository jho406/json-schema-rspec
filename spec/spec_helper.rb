require 'json-schema-rspec'

Dir[File.expand_path("../../spec/support/**/*.rb",__FILE__)].each { |f| require f }

RSpec.configure do |config|

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.filter_run_excluding wip: true

  config.include JSON::SchemaMatchers
end
