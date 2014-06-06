require 'spec_helper'

describe JSON::SchemaMatchers::MatchJsonSchemaMatcher do
  let(:valid_json)    { '"hello world"' }
  let(:inline_schema) { '{"type": "string"}' }
  let(:invalid_json)  { '{"key": "value"}' }

  context 'without valid schema_name' do
    specify 'matches fail' do
      expect(valid_json).not_to match_json_schema(:inline_schema)
    end

    specify 'strict matches fail' do
      expect(valid_json).not_to match_json_schema(:inline_schema)
    end

    specify 'assigns a failure message' do
      matcher = match_json_schema(:inline_schema)
      expect(matcher.matches?(valid_json)).to eq(false)
      expect(matcher.failure_message).to match(/^No schema defined for inline_schema/)
    end
  end

  context 'with valid schema_name' do
    before :each do
      RSpec.configuration.json_schemas[:inline_schema] = inline_schema
    end

    context 'finds a match' do
      specify 'when tested against valid json' do
        expect(valid_json).to match_json_schema(:inline_schema)
      end
    end

    context 'does not find a match' do
      let(:validator_errors) { [:error1, :error2] }

      specify 'when tested against invalid json' do
        expect(invalid_json).not_to match_json_schema(:inline_schema)
      end

      specify 'assigns a failure message' do
        expect(JSON::Validator).to receive(:fully_validate) { validator_errors.clone }
        matcher = match_json_schema(:inline_schema)
        expect(matcher.matches?(invalid_json)).to eq(false)
        expect(matcher.failure_message).to eq(expected_failure_message)
      end

      def expected_failure_message
        first_failure_message = "Expected JSON object to match schema identified by inline_schema, #{validator_errors.count} errors in validating"
        all_failure_messages = [first_failure_message, *validator_errors]
        all_failure_messages.join("\n")
      end
    end
  end
end
