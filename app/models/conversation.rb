class Conversation < ApplicationRecord
  has_many :users_conversations
  has_many :users, through: :users_conversations

  has_many :messages, dependent: :destroy

  validates :users, length: { minimum: 1 }

  before_save :set_title

  def balance(user)
    transactions = transactions.filter { |t| t.confirmed? }
    income, outcome = transactions.partition { |t| t.pay? }
    income.map(&:ammount).reduce(:+) - outcome.map(&:ammount).reduce(:+)
  end

  def transaction
    transactions.last
  end

  def set_title
    if title.empty? && users.length == 1
      self.title = users.first.name || users.first.number
    end
  end
end
