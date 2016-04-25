require 'test_helper'

RSpec.describe PMB::LabelTemplate do

	describe '#initialization' do

    it 'has an endpoint of label_templates' do
      expect(PMB::LabelTemplate.endpoint).to eql('label_templates')
    end
    
  end

  describe '#retrieve' do

    before do
      request_returns body: label_template_json
    end

    it 'retrieves a label template by id' do
      expect(RestClient::Request).to receive(:execute).with(
        "headers": { "content-type" => "application/vnd.api+json", :accept => :json },
        "method": :get,
        "url": 'http://pmb.dev/api/v1/label_templates/1'
      )

      label_template = PMB::LabelTemplate.retrieve(1)

      expect(label_template).to be_kind_of PMB::LabelTemplate

      expect(label_template.id).to eql("1")
      expect(label_template.type).to eql("label_templates")
      expect(label_template.attributes).to be_kind_of(Hash)
      expect(label_template.relationships).to be_kind_of(Hash)
      expect(label_template.relationships).to have_key("label_type")
      expect(label_template.relationships).to have_key("labels")

    end

  end

end