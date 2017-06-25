class Token < ActiveModelSerializers::Model
  ALG = 'HS256'
  # need for AMS
  attr_reader :token
  def attributes
    { token: @token }
  end

  def initialize(params)
    if params[:user_id]
      @user_id = params[:user_id]
      encode
    elsif params[:token]
      @token = params[:token]
      decode
    end
  end

  def pin
    @decoded["pin"]
  end

  def verified
    @decoded["verified"]
  end

  def verified=(params)
    encode verified: params
  end

  private

  def encode(params={})
    to_encrypt = { 
      user_id: @user_id,
      pin: params[:pin] || generate_pin,
      verified: params[:verified] || false
    }

    puts "______PIN__________: #{to_encrypt[:pin]}}"
    @token = JWT.encode(to_encrypt, secret, ALG)
  end

  def decode
    @decoded ||= JWT.decode(@token, secret, ALG).first
    @user_id = @decoded["user_id"]
  end

  def secret
    Rails.application.secrets.AUTH_SECRET
  end

  def generate_pin
    rand(0000..9999).to_s.rjust(4, "0")
  end
end