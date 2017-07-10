json.conversations @conversations do |conv|

  json.id conv.id
  json.balance conv.balance(@user)

  json.companions conv.users.select { |user| user.id != @user.id }

  json.transactions conv.transactions
end

