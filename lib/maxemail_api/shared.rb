module MaxemailApiShared
  class << self
    def send_request(params:, method:)
      response = HTTP.headers(authentication_header)
                     .get("#{ENV['MAXEMAIL_API_URL']}#{method}",
                          params: params)
      response
    end

    private

    def authentication_header
      { Authorization: 'Basic ' + Base64.encode64(ENV['MAXEMAIL_USERNAME'] + ':' + ENV['MAXEMAIL_PASSWORD']).chomp("\n") }
    end
  end
end
