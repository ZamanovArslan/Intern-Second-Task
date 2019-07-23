RSpec.configure do |config|
  # config.before(:all)  { FFaker::Random.seed = config.seed }
  # config.before(:each) { FFaker::Random.reset! }

  config.backtrace_exclusion_patterns << /\.bundle/

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end