require 'net/http'
require 'json'
require 'base64'
require 'date'

class QiwiService
  def initialize(phone)
    @phone = phone
    uri = URI('https://w.qiwi.com/oauth/authorize')
    body = Net::HTTP.post_form(uri, 'client_id' => 'qw-fintech', 'client_secret' => 'Xghj!bkjv64', 
      'client-software' => 'qw-fintech-0.0.1', 'response-type' => 'code', 'username' => @phone).body
    @code = JSON.parse(body)["code"]
  end

  def get_access_token(vcode)
    uri = URI('https://w.qiwi.com/oauth/access_token')
    body = Net::HTTP.post_form(uri, 'client_id' => 'qw-fintech', 'client_secret' => 'Xghj!bkjv64','client-software' => 'qw-fintech-0.0.1',
      'grant_type' => 'urn:qiwi:oauth:grant-type:vcode', 'code' => @code, 'vcode' => vcode).body
    return JSON.parse(body)["access_token"]
  end

  def pay(receiver, amount, access_token)
    uri = URI('https://sinap.qiwi.com/api/terms/99/payments')
    req = Net::HTTP::Post.new(uri)
    req['Authorization'] = "Token " + Base64.encode(@phone + ":" + access_token)
    req['Content-Type'] = 'application/json'
    req.body = {"fields" => {
        "account" => @phone,
        "prvld" => "99"
      },
      "id" => DateTime.now.strftime('%Q'),
      "paymentMethod" => {
        "type" => "Account",
        "accountId" => "643"
      },
      "sum" => {
        "amount" => amount,
        "currency" => "643"
      }
    }.to_json
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(req)
    end
    return JSON.parse(res.body)
  end
end