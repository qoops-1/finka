class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :receiver, class_name: "User"
  belongs_to :conversation

  enum type: [:charge, :pay]
end