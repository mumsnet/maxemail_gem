# Maxemail gem 💌
## Installation
 In your gemfile
 ```ruby
 gem 'maxemail_api'
```

 In your .env file:
 ```console
MAXEMAIL_USERNAME=techadmin@mumsnet.com
MAXEMAIL_PASSWORD=123456
MAXEMAIL_API_URL=https://maxemail.emailcenteruk.com/api/json/
```


## Usage

Sending a trigged mail:
 ```ruby
  def send_triggered
    profile_data = JSON.parse(params[:profile_data])
    email_address = ENV['DEV_EMAIL_ADDRESS'].nil? ? params[:email_address] : ENV['DEV_EMAIL_ADDRESS']
    response = MaxemailApi.send(folder_name: params[:folder_name], email_name: params[:email_name], email_id: params[:email_id], email_address: email_address, profile_data: profile_data)
    render json: response.to_json
  end
```
  
