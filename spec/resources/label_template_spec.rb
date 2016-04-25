require 'test_helper'

RSpec.shared_examples 'a createable label template resource' do

  it 'creates a new LabelTemplate resource' do
    expect(RestClient::Request).to receive(:execute).with(
      "headers": { "content-type" => "application/vnd.api+json", :accept => :json },
      "method": :post,
      "url": 'http://pmb.dev/api/v1/label_templates',
      "payload": label_template_creation_json
    )

    expect(subject).to be_kind_of PMB::LabelTemplate
    expect(subject.id).to eql("1")
    expect(subject.type).to eql("label_templates")

    attributes = subject.attributes
    expect(attributes).to be_kind_of(Hash)
    expect(attributes['name']).to eql("LabWhere")

    relationships = subject.relationships
    expect(relationships).to be_kind_of(Hash)
    expect(relationships).to have_key("label_type")
		expect(relationships).to have_key("labels")
  end

end

RSpec.describe PMB::LabelTemplate do

	describe '#initialization' do

    it 'has an endpoint of label_templates' do
      expect(PMB::LabelTemplate.endpoint).to eql('label_templates')
    end

  end

  describe '#create' do

    before do
      request_returns body: label_template_json
    end

    context 'with JSON' do

      subject { PMB::LabelTemplate.create(json: label_template_creation_json) }
      it_behaves_like 'a createable label template resource'

    end

    context 'with arguments' do

      subject do
        PMB::LabelTemplate.create(label_template_creation_struct["data"]["attributes"])
      end

      it_behaves_like 'a createable label template resource'

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