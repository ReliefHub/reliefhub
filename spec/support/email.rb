require "email_spec"

Spec::Runner.configure do |config|
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
end
