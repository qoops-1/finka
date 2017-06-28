class Conversation < ApplicationRecord
  has_many :users_conversations
  has_many :users, through: :users_conversations

  has_many :transactions, dependent: :destroy

  validates :users, length: { minimum: 2 }
  validate :check_title

  def balance(user)
    transactions = transactions&.select { |t| t.confirmed? }
    return 0 if transactions.nil?
    income, outcome = transactions.partition { |t| t.pay? }

    income = income.map(&:ammount).reduce(:+)
    outcome = outcome.map(&:ammount).reduce(:+)

    income = 0 if income.nil?
    outcome = 0 if outcome.nil?

    income - outcome
  end

  def transaction
    transactions.last
  end

  def check_title
    false if users.length > 2 && (title.nil? || title.empty?)
  end

  def title(user)
    return self[:title] if self[:title] || users.length > 2
    contact = users.select { |u| u != user }[0]
    contact.name || contact.phone
  end
end
