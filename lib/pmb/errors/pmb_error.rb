module PMB
  class PMBError < StandardError
    attr_reader :message
    attr_reader :http_status
    attr_reader :json_body

    def initialize(message=nil, http_status=nil, json_body=nil )
      @message = message
      @http_status = http_status
      @json_body = json_body
    end

    def to_s
      status_string = @http_status.nil? ? "" : "(Status #{@http_status}) "
      "#{status_string}#{@message}"
    end
  end
end