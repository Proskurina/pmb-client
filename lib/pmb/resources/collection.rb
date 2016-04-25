module PMB
  class Collection
    include Enumerable

    class << self
      attr_accessor :model, :endpoint
    end

    attr_accessor :values

    def initialize(args)
      update_attributes(args)
    end

    def self.retrieve
      new(PMB.request(:get, @endpoint))
    end

    def each(&blk)
      @values.each(&blk)
    end

  private

    def update_attributes(args)
      @values = args.map { |arg| self.class.model.new(arg) }
    end

  end
end