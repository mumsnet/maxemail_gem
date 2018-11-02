require 'spec_helper'
RSpec.describe MaxemailApiTriggered do
  describe '#send_triggerd' do
    it 'should send a triggerd mail' do
      # NOTE: Uncomment if you wana send yourself lots of mails!
      # response = described_class.send(folder_name: ENV['MAXEMAIL_TEST_FOLDER_NAME'], email_name: ENV['MAXEMAIL_TEST_EMAIL_NAME'], email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], profile_data: {})
      # expect(response.successful?).to be_truthy
      # expect(response.message).to eq('Mail sent')
      # NOTE: Uncomment if you wana send yourself lots of mails!
    end

    it 'should send a triggerd folder' do
      # NOTE: Uncomment if you wana send yourself lots of mails!
      # response = described_class.send(folder_name: ENV['MAXEMAIL_TEST_FOLDER_NAME'], email_name: ENV['MAXEMAIL_TEST_EMAIL_NAME'], email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], profile_data: {})
      # expect(response.successful?).to be_truthy
      # expect(response.message).to eq('Mail sent')
      # NOTE: Uncomment if you wana send yourself lots of mails!
    end

    it 'should fail to send a mail without a email_id or valid folder/email template names' do
      response = described_class.send(folder_name: 'InvalidFolder', email_name: 'InvalidEmail', email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], profile_data: {})
      expect(response.successful?).to be_falsey
      expect(response.message).to eq('Template not found')
    end

    it 'should fail to send a mail if invalid profile data is given' do
      response = described_class.send(email_id: 1, email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], profile_data: 'invalid')
      expect(response.successful?).to be_falsey
      expect(response.message).to eq('Invalid Profile data')
    end

    it 'should fail to send a mail if invalid email address is given' do
      response = described_class.send(folder_name: ENV['MAXEMAIL_TEST_FOLDER_NAME'], email_name: ENV['MAXEMAIL_TEST_EMAIL_NAME'], email_address: 'invalidemail', profile_data: {})
      expect(response.successful?).to be_falsey
      expect(response.message).to eq('Invalid Email address')
    end

    it 'should fail to send a mail if invalid email_id is given' do
      response = described_class.send(email_id: 99_999_999_999, email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], profile_data: {})
      expect(response.successful?).to be_falsey
      expect(response.message).to eq('Server error')
    end
  end
end
