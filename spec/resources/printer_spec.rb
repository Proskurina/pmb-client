require 'test_helper'

RSpec.shared_examples "a createable printer resource" do

  it 'sends a POST request to the API' do
    expect(RestClient::Request).to receive(:execute).with(
      "headers": { "content-type" => "application/vnd.api+json", :accept => :json },
      "method": :post,
      "url": 'http://pmb.dev/api/v1/printers',
      "payload": create_printer_json,
    )
    subject
  end

  it "returns a new PMB::Printer object" do
    expect(subject).to be_kind_of PMB::Printer
    expect(subject.id).to eql('1')
    expect(subject.type).to eql('printers')
    expect(subject.attributes["name"]).to eql('test_printer')
    expect(subject.attributes["protocol"]).to eql('LPD')
  end

end

RSpec.describe PMB::Printer do

  describe 'initialization' do

    before(:each) { @printer = PMB::Printer.new(printer_struct["data"]) }

    it 'is instatiated with a hash' do
      expect(@printer.id).to eql('1')
      expect(@printer.type).to eql('printers')
      expect(@printer.attributes).to be_kind_of Hash
    end

  end

  describe '#retrieve' do

    before do
      request_returns body: printer_json
    end

    it 'retrieves a printer by id' do
      expect(RestClient::Request).to receive(:execute).with(
        "headers": { "content-type" => "application/vnd.api+json", :accept => :json },
        "method": :get,
        "url": 'http://pmb.dev/api/v1/printers/1'
      )

      printer = PMB::Printer.retrieve(1)

      expect(printer).to be_kind_of PMB::Printer

      expect(printer.id).to eql('1')
      expect(printer.type).to eql('printers')

      expect(printer.attributes).to be_kind_of Hash
      expect(printer.attributes['name']).to eql('ippbc')
      expect(printer.attributes['protocol']).to eql('LPD')
    end

  end

  describe '#create' do

    let(:create_printer_json) {
      JSON.generate(
        data: {
          type: 'printers',
          attributes: {
            name: 'test_printer',
            protocol: 'LPD'
          }
        }
      )
    }

    before do
      request_returns body: printer_json(name: 'test_printer')
    end

    context 'with JSON' do
      subject { PMB::Printer.create(json: create_printer_json) }
      it_behaves_like 'a createable printer resource'
    end

    context 'with parameters' do
      subject { PMB::Printer.create(name: 'test_printer', protocol: PMB::Printer::LPD) }
      it_behaves_like 'a createable printer resource'
    end

  end

end