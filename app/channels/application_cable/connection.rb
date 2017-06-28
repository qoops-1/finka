module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable: ', current_user.id
    end

    private

    def find_verified_user
      auth_values = request&.params["token"]
      if !auth_values.nil?
        token = Token.new auth_values
      else
        token = nil
      end

      unless token
        reject_unauthorized_connection  
      end

      unless token.payload[:verified]
        reject_unauthorized_connection
      end

      User.find token.payload[:user_id]
    end
  end
end
