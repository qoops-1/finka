class Conversation < ApplicationRecord
  has_many :users_conversations
  has_many :users, through: :users_conversations

  has_many :transactions, dependent: :destroy

  validates :users, length: { minimum: 2 }
  validate :check_title, :conversation_exist

  def balance(user)
    # transactions = transactions&.select { |t| t.confirmed? }
    return 0 if transactions.nil?

    income = transactions.select { |t| t.receiver_id == user.id }

    outcome = transactions.select { |t| t.user_id == user.id}

    income = income.map(&:ammount).reduce(:+)
    outcome = outcome.map(&:ammount).reduce(:+)

    income = 0 if income.nil?
    outcome = 0 if outcome.nil?

    income - outcome
  end

  def transaction
    transactions.last
  end

  def title(user)
    return self[:title] if self[:title] || users.length > 2
    contact = users.select { |u| u != user }[0]
    contact&.name || contact.phone
  end

  private

  def check_title
    if users.length > 2 && (title.nil? || title.empty?)
      errors.add(:base, 'Fail title') 
    end
  end

  def conversation_exist
    if users.length == 2
      user_ids = users.map(&:id)
      conv_ids = Conversation
        .all
        .select { |c| c.users.count == 2 }
        .map(&:user_ids)
      conv_ids.each do |ids|
        errors.add(:base, 'Fail message') if user_ids == user_ids & ids
      end
    end
  end
end
