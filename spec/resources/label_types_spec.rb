require 'test_helper'

RSpec.describe PMB::LabelTypes do

  describe 'instanstiation' do

    it 'has an endpoint' do
      expect(PMB::LabelTypes.endpoint).to eql('label_types')
    end

    it 'creates a new PMB::LabelTypes collection with an array' do
      label_types = PMB::LabelTypes.new(label_types_struct['data'])
      expect(label_types).to be_kind_of PMB::LabelTypes
      expect(label_types).to all be_kind_of PMB::LabelType
      expect(label_types.count).to eql(3)
    end

  end

end