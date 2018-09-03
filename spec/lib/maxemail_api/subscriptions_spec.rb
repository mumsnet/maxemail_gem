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
      expect(response.body.to_s).to include('"list_id":"' + ENV['MAXEMAIL_TEST_LIST_ID'] + '","record_type":"campaign","subscribed":"1"')
      expect(response.body.to_s).to include('"email_address":"' + ENV['MAXEMAIL_TEST_EMAIL_ADDRESS'] + '')
    end
  end

  describe '#available_subscriptions' do
    it 'should fetch all of the users subscriptions' do
      lists = described_class.available_subscriptions
      expect(lists.to_s).to include('"list_id"=>"' + ENV['MAXEMAIL_TEST_LIST_ID'] + '"')
    end
  end
end
