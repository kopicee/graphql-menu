def differ
  RSpec::Support::Differ.new(
    color: RSpec::Matchers.configuration.color?
  )
end

RSpec::Matchers.define :match_controller_status do |expected_status, body_matcher|
  match do |response|
    actual_status = response.status
    actual_body = JSON.parse(response.body).deep_symbolize_keys

    actual_status == expected_status && body_matcher.matches?(actual_body)
  end

  failure_message do |response|
    actual_status = actual.status
    actual_body = JSON.parse(response.body).deep_symbolize_keys

    <<~TEXT
      Diff:
      #{differ.diff_as_object(actual_status, expected_status)}
      #{differ.diff_as_object(actual_body, body_matcher.expected)}
    TEXT
  end
end
