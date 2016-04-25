require 'test_helper'

RSpec.describe PMB do

  let(:api_base) { 'http://pmb.dev/api/v1' }
  let(:an_http_request) { PMB.request('method', 'uri') }

  after(:each) { PMB.api_base = api_base }

  describe 'initialization' do

    before { PMB.api_base = nil }

    it 'allows the api_base to be set' do
      PMB.api_base = api_base
      expect(PMB.api_base).to eql(api_base)
    end

  end

  describe '#request' do

    it 'throws an error if the api_base has not been set' do
      PMB.api_base = nil
      expect { an_http_request }.to raise_error(PMB::MissingApiBaseError)
    end

    it 'throws an error when it can\'t connect to the URI' do
      request_raises SocketError
      expect { an_http_request }.to raise_error(PMB::APIConnectionError)
    end

    it 'throws an error when the request times out' do
      request_raises RestClient::RequestTimeout
      expect { an_http_request }.to raise_error(PMB::APIConnectionError)
    end

    it 'throws an error when the server breaks the connection' do
      request_raises RestClient::ServerBrokeConnection
      expect { an_http_request }.to raise_error(PMB::APIConnectionError)
    end

    it 'throws an error when a request is invalid' do
      request_raises rest_client_exception(400)
      expect { an_http_request }.to raise_error(PMB::InvalidRequestError)
    end

    it 'throws an error when a request has an unprocessable entity' do
      request_raises rest_client_exception(422)
      expect { an_http_request }.to raise_error(PMB::InvalidRequestError)
    end

    it 'throws an error when a resource is not found' do
      request_raises rest_client_exception(404)
      expect { an_http_request }.to raise_error(PMB::InvalidRequestError)
    end

    it 'throws an error when the API errors' do
      request_raises rest_client_exception(500)
      expect { an_http_request }.to raise_error(PMB::APIError)
    end

    it 'throws an error when the JSON can not be parsed' do
      request_returns body: "This isn't valid JSON!!!*@(Y", code: 200
      expect { an_http_request }.to raise_error(PMB::APIError)
    end

  end

end