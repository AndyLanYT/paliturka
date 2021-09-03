require 'simplecov'
SimpleCov.start do
  add_filter '/config/'
  add_filter '/spec/'
  add_filter '/lib/devise_custom_failure.rb'

  add_group 'Model', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Jobs', 'app/jobs'
  add_group 'Mailers', 'app/mailers'
  add_group 'Serializers', 'app/serializers'
  add_group 'Policies', 'app/policies'
  # add_group "Views", "app/views"
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
