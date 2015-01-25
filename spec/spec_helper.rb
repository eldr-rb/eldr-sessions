if ENV['COVERALLS_REPO_TOKEN']
  require 'coveralls'
  Coveralls.wear!
end

require 'rack/test'
require 'rack'

# Hardcode an instance into a global because rack-test likes to get too clever
RSpec.configure do |config|
  config.include Rack::Test::Methods
end
