module MaxemailApiShared
  class << self
    def send_request(params:, method:)
      puts 'MaxemailApiResponse params and Method:'
      puts "params: #{params}"
      puts "method: #{method}"
      puts 'END MaxemailApiResponse params and Method:'
      response = HTTP.headers(authentication_header)
                     .get("#{ENV['MAXEMAIL_API_URL']}#{method}",
                          params: params)
      puts 'MaxemailApiResponse:'
      puts response
      puts 'END MaxemailApiResponse :'
      response
    end

    private

    def authentication_header
      { Authorization: 'Basic ' + Base64.encode64(ENV['MAXEMAIL_USERNAME'] + ':' + ENV['MAXEMAIL_PASSWORD']).chomp("\n") }
    end
  end
end
