require 'restclient'
require 'json'

login_response = RestClient.post(
  "localhost:9292/api/v1/sessions",
  {
    "email" => "a@a.com",
    "password" => "123456"
  }.to_json,
  {content_type: :json}
)

login_response.code # => 200
login_response.body # => "{\"private_token\":\"85429ebf64b0\"}"
parsed_json = JSON.parse(login_response.body)
private_token = parsed_json["private_token"] # => "85429ebf64b0"




