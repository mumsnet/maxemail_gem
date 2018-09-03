module MaxemailApiSubscriptions
  extend self
  include MaxemailApiShared

  def subscribe(email_address:, list_id:)
    return MaxemailApiShared.send_request(params: { method: 'insertRecipient', data: { email_address: email_address, subscribed: 1 }.to_json, listID: list_id }, method: 'recipient') unless inserted?(email_address: email_address, list_id: list_id)
    MaxemailApiShared.send_request(params: { method: 'updateRecipient', data: { email_address: email_address, subscribed: 1 }.to_json, listID: list_id, recipientId: find_recipient_id(email_address: email_address) }, method: 'list')
  end

  def subscribed?(email_address:, list_id:)
    response = MaxemailApiShared.send_request(params: { method: 'fetchRecipient', listID: list_id, recipientId: find_recipient_id(email_address: email_address) }, method: 'list')
    return false if response.body.to_s == 'false'
    response = JSON.parse(response.body)
    return false if response['success'].to_s == 'false'
    return false if response['subscribed'].to_s == '0'
    return true if response['subscribed'].to_s == '1'
  rescue StandardError
    false
  end

  def inserted?(email_address:, list_id:)
    response = MaxemailApiShared.send_request(params: { method: 'fetchRecipient', listID: list_id, recipientId: find_recipient_id(email_address: email_address) }, method: 'list')
    return false if response.body.to_s == 'false'
    response = JSON.parse(response.body)
    return false if response['success'].to_s == 'false'
    return true if response['subscribed'].to_s == '0'
    return true if response['subscribed'].to_s == '1'
  rescue StandardError
    false
  end

  def unsu9bscribe(email_address: nil, recipient_id: nil, list_id:)
    recipient_id = find_recipient_id(email_address: email_address) if recipient_id.nil?
    MaxemailApiShared.send_request(params: { method: 'updateRecipient', data: { email_address: email_address, subscribed: 0 }.to_json, listID: list_id, recipientId: recipient_id }, method: 'list')
  end

  def subscriptions(email_address: nil, recipient_id: nil, list_id:)
    recipient_id = find_recipient_id(email_address: email_address) if recipient_id.nil?
    MaxemailApiShared.send_request(params: { method: 'fetchLists', listID: list_id, recipientId: recipient_id }, method: 'recipient')
  end

  def find_recipient_id(email_address: nil)
    MaxemailApiShared.send_request(params: { method: 'findByEmailAddress', emailAddress: email_address }, method: 'recipient')
  end

  def available_subscriptions
    lists = JSON.parse(fetch_list)
    lists.delete_if { |list| list['type'] != 'include' }
  end

  def fetch_list
    MaxemailApiShared.send_request(params: { method: 'fetchAll' }, method: 'list')
  end
end
