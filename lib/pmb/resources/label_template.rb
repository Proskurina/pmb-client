module PMB
  class LabelTemplate < PMB::Resource

  	self.endpoint = 'label_templates'

  	attr_accessor :id, :type, :attributes, :relationships

  end
end