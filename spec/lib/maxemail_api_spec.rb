require 'spec_helper'
RSpec.describe MaxemailApi do
  it 'should be able to call methods in triggered and subscriptions' do
    described_class.subscribe(email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], list_id: ENV['MAXEMAIL_TEST_LIST_ID'])
    expect(described_class.subscribed?(email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], list_id: ENV['MAXEMAIL_TEST_LIST_ID'])).to be_truthy
    described_class.unsubscribe(email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], list_id: ENV['MAXEMAIL_TEST_LIST_ID'])
    described_class.send(folder_name: 'InvalidFolder', email_name: 'InvalidEmail', email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], profile_data: {})
  end
end
