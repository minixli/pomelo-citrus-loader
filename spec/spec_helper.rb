# Author:: MinixLi (gmail: MinixLi1986)
# Homepage:: http://citrus.inspawn.com
# Date:: 16 July 2014

require File.expand_path('../../lib/citrus-loader', __FILE__)

RSpec.configure { |config|
  config.mock_with(:rspec) { |c|
    c.syntax = [:should, :expect]
  }
  config.expect_with(:rspec) { |c|
    c.syntax = [:should, :expect]
  }
}
