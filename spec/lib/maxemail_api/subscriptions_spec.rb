require 'spec_helper'
RSpec.describe MaxemailApiSubscriptions do
  describe '#subscribe' do
    it 'should subscribe user to the list' do
      response = described_class.subscribe(email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], list_id: ENV['MAXEMAIL_TEST_LIST_ID'])
      expect(response.body.to_s).to include('"subscribed":"1"')
      expect(response.body.to_s).to include('"email_address":"' + ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'] + '"')
    end
  end

  describe '#subscribed?' do
    it 'should subscribe user to the list then return TRUE for subscribed?' do
      described_class.subscribe(email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], list_id: ENV['MAXEMAIL_TEST_LIST_ID'])
      # Subscribe the user to the mailing list
      response = described_class.subscribed?(email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], list_id: ENV['MAXEMAIL_TEST_LIST_ID'])
      expect(response).to be_truthy
      # Then they should be subscribed
    end

    it 'should unsubscribe user to the list then return FALSE for subscribed?' do
      described_class.unsubscribe(email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], list_id: ENV['MAXEMAIL_TEST_LIST_ID'])
      # Unsubscribe the user to the mailing list
      response = described_class.subscribed?(email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], list_id: ENV['MAXEMAIL_TEST_LIST_ID'])
      expect(response).to be_falsey
      # Then they should be subscribed
    end
  end

  describe '#unsubscribe' do
    it 'should fetch all of the users subscriptions' do
      response = described_class.unsubscribe(email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], list_id: ENV['MAXEMAIL_TEST_LIST_ID'])
      expect(response.body.to_s).to include('"subscribed":"0"')
      expect(response.body.to_s).to include('"email_address":"' + ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'] + '"')
    end
  end

  describe '#subscriptions' do
    it 'should fetch all of the users subscriptions' do
      described_class.subscribe(email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], list_id: ENV['MAXEMAIL_TEST_LIST_ID'])
      # Subscribe the user to the mailing list
      response = described_class.subscriptions(email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], list_id: ENV['MAXEMAIL_TEST_LIST_ID'])
      # Expect the response to include that list id with subscribe = 1 and the users email address
      expect(response.body.to_s).to include('"list_id":"' + ENV['MAXEMAIL_TEST_LIST_ID'] + '","record_type":"both","subscribed":"1"')
      expect(response.body.to_s).to include('"email_address":"' + ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'] + '')
    end
  end

  describe '#update_subscription_email' do
    it 'update the recipients email' do
      recipient_id = described_class.find_recipient_id(email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS']).to_s
      range = [*'0'..'9', *'A'..'Z', *'a'..'z']
      prefix = Array.new(10) { range.sample }.join
      new_email_address = prefix + '@0805aSDac4.com'
      described_class.update_subscription_email(new_email_address: new_email_address, recipient_id: recipient_id)
      expect(described_class.find_recipient_id(email_address: new_email_address).to_s).to eq(recipient_id)
      response = described_class.find_recipient_id(email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS']).to_s
      expect(response.to_s).to eq('')
      described_class.update_subscription_email(new_email_address: ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'], recipient_id: recipient_id)
    end
  end

  describe '#available_subscriptions' do
    it 'should fetch all of the users subscriptions' do
      lists = described_class.available_subscriptions
      expect(lists.to_s).to include('"list_id"=>"' + ENV['MAXEMAIL_TEST_LIST_ID'] + '"')
    end
  end
end
