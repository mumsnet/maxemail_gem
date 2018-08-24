require 'base64'
require 'http'
require 'json'
require 'maxemail_api/shared'
require 'maxemail_api/response'
require 'maxemail_api/triggered'
require 'maxemail_api/subscriptions'
module MaxemailApi
  class << self
    def send(folder_name:, email_name:, email_id:, email_address:, profile_data:)
      email_id = MaxemailApiTriggered.find_email_id(folder_name: folder_name, email_name: email_name) if email_id.nil?
      MaxemailApiTriggered.send_triggered(email_address: email_address, email_id: email_id, profile_data: profile_data)
    end
  end
end
