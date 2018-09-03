module MaxemailApiShared
  class << self
    def send_request(params:, method:)
      HTTP.headers(authentication_header)
          .get("#{ENV['MAXEMAIL_API_URL']}#{method}",
               params: params)
    end

    private

    def authentication_header
      { Authorization: 'Basic ' + Base64.encode64(ENV['MAXEMAIL_USERNAME'] + ':' + ENV['MAXEMAIL_PASSWORD']).chomp("\n") }
    end
  end
end
