$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pmb'
require 'rspec'
require_relative '../spec/fixtures'
require 'factory_girl'

include PMB::Fixtures

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end

PMB.api_base = 'http://pmb.dev/api/v1'

# RestClient related helpers
def request_raises(exception)
  allow(RestClient::Request).to receive(:execute).and_raise(exception)
end

def request_returns(response_params)
  allow(RestClient::Request).to receive(:execute)
    .and_return(instance_double(RestClient::Response, response_params))
end

def rest_client_exception(code)
  RestClient::Exceptions::EXCEPTIONS_MAP.fetch(code).new(nil, code)
end

def openstruct_to_hash(object, hash = {})
  object.each_pair do |key, value|
    hash[key] = value.is_a?(OpenStruct) ? openstruct_to_hash(value) : value
  end
  hash
end