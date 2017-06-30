require 'net/http'
require 'json'
require 'base64'
require 'date'

class Qiwi
  def self.get_code(phone)
    uri = URI('https://w.qiwi.com/oauth/authorize')
    body = Net::HTTP.post_form(uri,
      client_id: 'qw-fintech',
      client_secret: 'Xghj!bkjv64', 
      "client-software" => 'qw-fintech-0.0.1',
      response_type: 'code',
      username: phone
    ).body
    JSON.parse(body)["code"]
  end

  def self.get_token(pin, code)
    uri = URI('https://w.qiwi.com/oauth/access_token')
    body = Net::HTTP.post_form(uri, {
      client_id: 'qw-fintech',
      client_secret: 'Xghj!bkjv64',
      'client-software' => 'qw-fintech-0.0.1',
      grant_type: 'urn:qiwi:oauth:grant-type:vcode',
      code: code,
      vcode: pin
    }).body
    JSON.parse(body)
    JSON.parse(body)["access_token"]
  end

  def self.pay(sender, receiver, amount, access_token)
    url = URI("https://sinap.qiwi.com/api/terms/99/payments")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    code_string = "#{sender}:#{access_token}"
    id = DateTime.now.strftime('%Q')

    request = Net::HTTP::Post.new(url)
    request["authorization"] = "Token #{Base64.encode64(code_string).strip}"
    request["content-type"] = 'application/json'
    request["accept"] = 'application/vnd.qiwi.v2+json'
    request["accept-encoding"] = 'gzip, deflate, compress'
    request["user-agent"] = 'HTTPie/0.3.0'
    request.body = "{\n    \"fields\":{\n      \"account\":\"#{receiver}\",\n      \"prvld\":\"99\"\n    },\n    \"id\": \"#{id}\",\n    \"paymentMethod\": {\n      \"type\": \"Account\",\n      \"accountId\": \"643\"\n    },\n    \"sum\": {\n      \"amount\": \"#{amount}\",\n      \"currency\": \"643\"\n    }\n}"
    http.request(request).code
  end
end
