require 'base64'
require 'http'
require 'json'
require 'maxemail_api/shared'
require 'maxemail_api/response'
require 'maxemail_api/triggered'
require 'maxemail_api/subscriptions'

class MaxemailApi
  extend MaxemailApiSubscriptions
  extend MaxemailApiTriggered
end
