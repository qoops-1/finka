class Api::ConversationSerializer < ActiveModel::Serializer
  attributes :title

  has_many :users
end
