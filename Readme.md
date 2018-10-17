# Maxemail gem 💌
Please view the API Doc's and read the source code for other usages of this gem:
* [API Docs](https://mumsnet.postman.co/collections/4542578-890f57a2-e5b8-47f4-9b09-b6da9a36795c?workspace=dfc06a8c-8a1d-4315-89b9-2534aaf620cb)
* [TERIBLE "OFFICIAL" Docs](https://docs.maxemail.xtremepush.com/mxm-dev/api)

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
  
Update prefrences (Subscriptions):
 ```ruby
def update_subscriptions(email_address:, params:)
  MaxemailApi.update_recipient(email_address: email_address, data: { Preferences: params }.to_json)
end
```
