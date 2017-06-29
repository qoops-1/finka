require 'uri'
require 'net/http'

class Pin
  def self.send(pin, adr)
    url = URI("http://web.smsgorod.ru/sendsms.php?user=bainst4&pwd=Dianok4ever&sadr=ZAMENA&text=#{pin}&dadr=#{adr}")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url)

    response = http.request(request)
    puts response.read_body
  end
end