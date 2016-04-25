require 'test_helper'

RSpec.describe PMB::LabelTemplates do

  describe 'instanstiation' do

    it 'has an endpoint' do
      expect(PMB::LabelTemplates.endpoint).to eql('label_templates')
    end

    it 'creates a new PMB::LabelTemplates collection with an array' do
      label_templates = PMB::LabelTemplates.new(label_templates_struct['data'])
      expect(label_templates).to be_kind_of PMB::LabelTemplates
      expect(label_templates).to all be_kind_of PMB::LabelTemplate
      expect(label_templates.count).to eql(5)
    end

  end

end