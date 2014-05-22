# JSON::SchemaMatchers

This gem adds matchers to rspec for validating JSON strings against [JSON schemas](http://json-schema.org).

JSON schemas are great for ensuring that changes in applications don't break their integrations, without having to write complex integration tests or run many application environments on your development machine.

## Installation

Add this line to your application's Gemfile:

    gem 'json-schema-rspec'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json-schema-rspec

## Usage

In your `spec_helper.rb`:

    config.include JSON::SchemaMatchers

	#schema file
    config.json_schemas[:my_schema] = "path/to/schema.json"
    #inline
    config.json_schemas[:inline_schema] = '{"type": "string"}'
    
You can then write tests such as:

	#passing spec
    expect('"hello world"').to match_json_schema(:inline_schema)
    
    #failing spec
    expect('[1, 2, 3]').to match_json_schema(:inline_schema)

#### Strict schema validation

If you wish to use strict schema validation you can do so by passing an additional argument to the matcher.
strict validation can be useful if you want to ensure there are no additional properties in the JSON than
those explicitly defined in your schema

```
expect(response.body).to match_json_schema(:my_schema, strict: true)
```
    
### Schema in a file
You can also use rails path utilities such as `Rails.root.join("spec/support/schemas/my_business_object.schema.json").to_s` when defining schema locations. This gem is backed by the [json-schema](http://github.com/hoxworth/json-schema) gem, so whatever that validator accepts  for paths should work.

### Inline Schema
While not recommended due to their size, inline schemas are supported. This may be useful for very simple schemas or if schemas are generated dynamically from some other process.

### Remote Schemas
Reading a schema from a web address is also supported, but with some limitations. Under the covers, the json-schema gem uses simple ruby `open` and `read` methods, so tread lightly. Accessing resources that are restricted by even simple HTTP auth will probably not work.

One work-around here would be to read your schema using some other mechanism (such as the `RestClient` gem) and passing it to `config.json_schemas` as an inline schema.

    config.json_schemas[:remote_protected_object] = RestClient.get("http://username:password@artifacts.sharethrough.com/object.schema.json")

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
