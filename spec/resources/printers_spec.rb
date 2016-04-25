require 'test_helper'

RSpec.describe PMB::Printers do

  describe 'instantiation' do

    before(:each) { @printers = PMB::Printers.new(printers_struct["data"]) }

    it 'is instantiated from an array of hashes' do
      expect(@printers).to all be_a_kind_of(PMB::Printer)
    end

  end

  describe '#retrieve' do

    it 'fetches all printers' do
      request_returns body: printers_json

      expect(RestClient::Request).to receive(:execute).with(
        "headers": { "content-type" => "application/vnd.api+json", :accept => :json },
        "method": :get,
        "url": 'http://pmb.dev/api/v1/printers'
      )

      printers = PMB::Printers.retrieve()

      expect(printers).to be_a_kind_of(PMB::Printers)
      expect(printers).to all be_a_kind_of(PMB::Printer)
    end

  end

end