class Conversation < ApplicationRecord
  has_many :participants, dependent: :destroy
end
