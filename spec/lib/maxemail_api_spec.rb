require 'spec_helper'
RSpec.describe MaxemailApi do
  describe '#send_triggerd' do
    it 'should send a triggerd mail' do
      response = described_class.send(folder_name: ENV['MAXEMAIL_TEST_FOLDER_NAME'], email_name: ENV['MAXEMAIL_TEST_EMAIL_NAME'], email_id: nil, email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], profile_data: {})
      puts response.to_json
      puts response.to_json
      puts response.to_json
      puts response.to_json
    end
  end
end
