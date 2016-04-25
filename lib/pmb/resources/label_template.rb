module PMB
  class LabelTemplate < PMB::Resource

  	self.endpoint = 'label_templates'

  	attr_accessor :id, :type, :attributes, :relationships

  	def self.to_json(args)
      return LabelTemplateCreation.new(args).to_json
    end

    LabelTemplateCreation = Struct.new(:attributes) do

      def to_json
        JSON.generate(
          data: {
            attributes: attributes
          }
        )
      end

    end

  end
end