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

users_response = RestClient.get(
  "localhost:9292/api/v1/users?private_token=#{private_token}"
)



users_response.code # => 200
users_response.body # => "[{\"id\":1,\"amount\":5000,\"approval_status\":false,\"created_at\":\"2017-05-15T04:24:59.296Z\",\"updated_at\":\"2017-05-15T04:24:59.296Z\",\"user_id\":1}]"
p parsed_users = JSON.parse(attendances_response.body) # !> assigned but unused variable - parsed_attendances
# >> [{"id"=>1, "amount"=>5000, "approval_status"=>false, "created_at"=>"2017-05-15T04:24:59.296Z", "updated_at"=>"2017-05-15T04:24:59.296Z", "user_id"=>1}]


