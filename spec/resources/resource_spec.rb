require 'test_helper'

RSpec.describe PMB::Resource do

  it 'allows the endpoint to be set' do
    PMB::Resource.endpoint = 'pmb_test'
    expect(PMB::Resource.endpoint).to eql('pmb_test')
  end

end