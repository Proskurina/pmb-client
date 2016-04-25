module PMB
  class Resource

    class << self
      attr_accessor :endpoint
    end

    def initialize(args)
      update_attributes(args)
    end

    def self.retrieve(id)
      new(PMB.request(:get, "#{@endpoint}/#{id}"))
    end

    def self.create(args)
      json = args.fetch(:json, to_json(args))
      request_response = PMB.request(:post, @endpoint, payload: json)
      new(request_response)
    end

  private

    def update_attributes(args)
      args.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

  end
end