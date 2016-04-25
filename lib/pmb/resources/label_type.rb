module PMB
  class LabelType < PMB::Resource

    self.endpoint = 'label_types'

    attr_accessor :id, :type, :attributes

    def self.to_json(args)
      return LabelTypeCreation.new(args).to_json
    end

    LabelTypeCreation = Struct.new(:attributes) do

      def to_json
        JSON.generate(
          data: {
            type: 'label_types',
            attributes: attributes
          }
        )
      end

    end

  end
end