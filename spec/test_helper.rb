$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pmb'
require 'rspec'
require_relative '../spec/fixtures'

include PMB::Fixtures

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