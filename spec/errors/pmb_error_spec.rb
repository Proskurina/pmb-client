require 'test_helper'

RSpec.describe PMB::PMBError do

  before { @pmb_error = PMB::PMBError.new('There was an error', 400, "{\"error\": \"Something wen wrong\"}") }

  describe '#to_s'
    it 'returns a formatted message' do
      expect(@pmb_error.to_s).to eql('(Status 400) There was an error')
    end

end