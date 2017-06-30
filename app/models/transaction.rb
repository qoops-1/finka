class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :receiver, class_name: "User"
  belongs_to :conversation

  enum kind: [:charge, :pay]

  default_scope { order(created_at: :desc) }
end
