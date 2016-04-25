# External dependencies
require 'json'
require 'rest-client'

# Version
require 'pmb/version'

# Resources
require 'pmb/resources/resource'
require 'pmb/resources/printer'
require 'pmb/resources/print_job'
require 'pmb/resources/label_type'

# Collection Resources
require 'pmb/resources/collection'
require 'pmb/resources/printers'
require 'pmb/resources/label_types'

# Errors
require 'pmb/errors/pmb_error'
require 'pmb/errors/missing_api_base'
require 'pmb/errors/api_connection'
require 'pmb/errors/invalid_request'
require 'pmb/errors/api_error'

module PMB

  class << self
    attr_accessor :api_base
  end

  def self.request(method, url, params = {})

    unless @api_base
      raise missing_api_base_error('No api_base has been set. ' \
        'You can set it on the PMB module:' \
        'PMB.api_base = \'http://pmb.dev:321/api/v1\''
      )
    end

    url = [api_base, url].join('/')

    request_params = request_params(method: method, url: url).merge(params)

    http_response = execute_request_with_rescues(request_params)

    return parse(http_response)
  end

private

  def self.execute_request(opts)
    RestClient::Request.execute(opts)
  end

  def self.execute_request_with_rescues(opts)
    begin
      response = execute_request(opts)

    # api_base probably hasn't been set correctly
    rescue SocketError => e
      raise api_connection_error("Could not connect to API: #{opts['url']}")

    # something is wrong with the network
    rescue RestClient::RequestTimeout, RestClient::ServerBrokeConnection => e
      raise api_connection_error(e.message)

    # either the server is behaving unexpectedly, or the request was invalid
    rescue RestClient::Exception => e
      handle_api_error(e)
    end
  end

  def self.request_params(opts = {})
    {
      headers: {
        "content-type" => "application/vnd.api+json",
        accept: :json
      }
    }.merge(opts)
  end

  def self.parse(http_response)
    begin
      response = JSON.parse(http_response.body)
    rescue JSON::ParserError => e
      raise api_error("The response from the API could not be parsed. " \
        "The HTTP code was #{http_response.code}")
    end

    return response['data']
  end

  def self.handle_api_error(e)
    case e.http_code
      when 400, 404, 422
        raise invalid_request_error(e.message)
      else
        raise api_error(e.message)
    end
  end

  def self.missing_api_base_error(message)
    PMB::MissingApiBaseError.new(message)
  end

  def self.api_connection_error(message)
    PMB::APIConnectionError.new(message)
  end

  def self.invalid_request_error(message)
    PMB::InvalidRequestError.new(message)
  end

  def self.api_error(message)
    PMB::APIError.new(message)
  end

end