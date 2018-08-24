require 'spec_helper'
RSpec.describe MaxemailApiResponse do
  describe 'self' do
    it 'should send a triggerd mail' do
      response = JSON.parse(described_class.new(data: { mail_sent: true }, success: true, message: 'Well done!').to_json)
      expect(response['data']['mail_sent']).to be_truthy
      expect(response['data']['success']).to be_truthy
      expect(response['data']['message']).to eq('Well done!')
    end
  end
end
