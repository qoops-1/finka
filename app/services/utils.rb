class Utils
  def self.format_phone(phone)
    if phone =~ /(7|\+7|8|)(\d{10})$/
      return "7#{$2}"
    else
      raise 'Invalid number'
    end
  end
end