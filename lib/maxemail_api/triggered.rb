module MaxemailApiTriggered
  extend self
  include MaxemailApiShared

  def send(folder_name: nil, email_name: nil, email_id: nil, email_address:, profile_data:)
    email_id = MaxemailApiTriggered.find_email_id(folder_name: folder_name, email_name: email_name) if email_id.nil?
    MaxemailApiTriggered.send_triggered(email_address: email_address, email_id: email_id, profile_data: profile_data)
  end

  def trigger_folder(folder_id:, email_address:, profile_data:)
    return MaxemailApiResponse.new(data: {}, success: false, message: 'Folder not found') if folder_id.nil?
    return MaxemailApiResponse.new(data: {}, success: false, message: 'Invalid Profile data') unless valid_profile_data?(profile_data)
    return MaxemailApiResponse.new(data: {}, success: false, message: 'Invalid Email address') unless valid_email?(email_address)
    response = JSON.parse(MaxemailApiShared.send_request(params: { method: 'triggerFolder',
                                                                   emailAddress: email_address,
                                                                   folderId: folder_id,
                                                                   profileData: profile_data.to_json }, method: 'email_send').body)
    return MaxemailApiResponse.new(data: {}, success: true, message: 'Mail sent') if response['success'] == true
    return MaxemailApiResponse.new(data: {}, success: false, message: 'Server error') if response['success'] == false
  rescue StandardError => e
    puts 'MaxemailApiResponse Error:'
    puts e
    puts "profile_data: #{profile_data}"
    puts 'END MaxemailApiResponse Error:'
    MaxemailApiResponse.new(data: {}, success: false, message: 'Server error')
  end

  def send_triggered(email_address: nil, email_id: nil, profile_data: nil)
    return MaxemailApiResponse.new(data: {}, success: false, message: 'Template not found') if email_id.nil?
    return MaxemailApiResponse.new(data: {}, success: false, message: 'Invalid Profile data') unless valid_profile_data?(profile_data)
    return MaxemailApiResponse.new(data: {}, success: false, message: 'Invalid Email address') unless valid_email?(email_address)
    response = JSON.parse(MaxemailApiShared.send_request(params: { method: 'trigger',
                                                                   emailAddress: email_address,
                                                                   emailId: email_id,
                                                                   profileData: profile_data.to_json }, method: 'email_send').body)

    return MaxemailApiResponse.new(data: {}, success: true, message: 'Mail sent') if response['success'] == true
    return MaxemailApiResponse.new(data: {}, success: false, message: 'Server error') if response['success'] == false
  rescue StandardError => e
    puts 'MaxemailApiResponse Error:'
    puts e
    puts 'END MaxemailApiResponse Error:'
    return MaxemailApiResponse.new(data: {}, success: false, message: 'Server error') if response['success'] == false
  end

  def find_email_id(folder_name: nil, email_name: nil)
    folder_id = find_folder_id(folder_name: folder_name)
    response = JSON.parse(fetch_tree(tree: 'email', node_id: folder_id, node_class: 'folder'))
    response.map do |node|
      node['nodeId'].to_i if node['text'] == email_name
    end.compact.first
  rescue StandardError
    nil
  end

  def fetch_root(tree: 'email', children: '[]')
    MaxemailApiShared.send_request(params: { method: 'fetchRoot',
                                             tree: tree,
                                             children: children }, method: 'tree')
  end

  def fetch_tree(tree: 'email', node_id: nil, node_class: 'folder')
    MaxemailApiShared.send_request(params: { method: 'fetchTree',
                                             tree: tree,
                                             nodeId: node_id,
                                             nodeClass: node_class }, method: 'tree')
  end

  def fetch_trigged(folder_id: nil)
    MaxemailApiShared.send_request(params: { method: 'fetchAll',
                                             folderId: folder_id }, method: 'email_triggered')
  end

  def find_folder_id(folder_name: nil)
    response = JSON.parse(fetch_root)
    response[0]['children'].map do |node|
      node['nodeId'].to_i if node['text'] == folder_name
    end.compact.first
  rescue StandardError
    nil
  end

  def valid_email?(email_address)
    email_address.match(URI::MailTo::EMAIL_REGEXP).present?
  rescue StandardError
    false
  end

  def valid_profile_data?(profile_data)
    JSON.parse(profile_data.to_json)
    true
  rescue StandardError
    false
  end
end
