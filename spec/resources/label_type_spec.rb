require 'test_helper'

RSpec.shared_examples 'a createable label type resource' do

  it 'creates a new LabelType resource' do
    expect(RestClient::Request).to receive(:execute).with(
      "headers": { "content-type" => "application/vnd.api+json", :accept => :json },
      "method": :post,
      "url": 'http://pmb.dev/api/v1/label_types',
      "payload": create_label_type_json
    )

    expect(subject).to be_kind_of PMB::LabelType
    expect(subject.id).to eql("1")
    expect(subject.type).to eql("label_types")

    attributes = subject.attributes

    expect(attributes).to be_kind_of(Hash)
    expect(attributes['feed_value']).to eql("008")
    expect(attributes['fine_adjustment']).to eql("04")
    expect(attributes['pitch_length']).to eql("0110")
    expect(attributes['print_width']).to eql("0920")
    expect(attributes['print_length']).to eql("0080")
    expect(attributes['name']).to eql("Plate")
  end

end

RSpec.describe PMB::LabelType do

  describe '#initialization' do

    it 'has an endpoint of label_types' do
      expect(PMB::LabelType.endpoint).to eql('label_types')
    end

    it 'is instantiated with a hash' do
      label_type = PMB::LabelType.new(label_type_struct['data'])
      expect(label_type.id).to eql("1")
      expect(label_type.type).to eql("label_types")
      expect(label_type.attributes).to be_kind_of(Hash)
    end

  end

  describe '#create' do

    before do
      request_returns body: label_type_json
    end

    let(:create_label_type_json) do
      JSON.generate(
        data: {
          type: 'label_types',
          attributes: {
            feed_value: "008",
            fine_adjustment: "04",
            pitch_length: "0110",
            print_width: "0920",
            print_length: "0080",
            name: "Plate"
          }
        }
      )
    end

    context 'with JSON' do

      subject { PMB::LabelType.create(json: create_label_type_json) }
      it_behaves_like 'a createable label type resource'

    end

    context 'with arguments' do

      subject do
        PMB::LabelType.create(
          feed_value: "008",
          fine_adjustment: "04",
          pitch_length: "0110",
          print_width: "0920",
          print_length: "0080",
          name: "Plate"
        )
      end

      it_behaves_like 'a createable label type resource'

    end

  end

  describe '#retrieve' do

    before do
      request_returns body: label_type_json
    end

    it 'retrieves a label type by id' do
      expect(RestClient::Request).to receive(:execute).with(
        "headers": { "content-type" => "application/vnd.api+json", :accept => :json },
        "method": :get,
        "url": 'http://pmb.dev/api/v1/label_types/1'
      )

      label_type = PMB::LabelType.retrieve(1)

      expect(label_type).to be_kind_of PMB::LabelType

      expect(label_type.id).to eql("1")
      expect(label_type.type).to eql("label_types")
      expect(label_type.attributes).to be_kind_of(Hash)
    end

  end

end