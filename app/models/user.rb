class User < ApplicationRecord
  has_many :users_conversations
  has_many :conversations, through: :users_conversations
  has_many :transactions
end
