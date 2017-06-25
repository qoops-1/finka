class Token < ActiveModelSerializers::Model
  ALG = 'HS256'
  # need for AMS
  attr_reader :token, :payload
  def attributes
    {
      token: @token,
      payload: @payload
    }
  end

  # receives payload as a hash or a JWT token
  def initialize(parameter)
    if parameter.is_a? Hash
      @payload = parameter
      encode
    else
      @token = parameter
      decode
    end
  end

  def pin
    @payload[:pin]
  end

  def verified
    @payload[:verified]
  end

  def verified=(value)
    encode verified: value
  end

  private

  def encode(params={})
    params.each { |k, v| @payload[k] = v }
    @payload[:pin] ||= generate_pin
    @payload[:verified] ||= false

    @payload = @payload
    @token = JWT.encode(@payload, secret, ALG)
  end

  def decode
    @payload = JWT.decode(@token, secret, ALG).first.symbolize_keys
  end

  def secret
    Rails.application.secrets.AUTH_SECRET
  end

  def generate_pin
    rand(0000..9999).to_s.rjust(4, "0")
  end
end