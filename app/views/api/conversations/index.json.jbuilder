json.conversations @conversations do |conv|

  json.id conv.id
  json.balance conv.balance(@user)

  json.companions @conversation.users.select { |user| user.id != @user.id }

  json.transactions conv.transactions
end

