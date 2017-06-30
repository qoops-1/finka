json.conversations @conversations do |conv|
  json.conversation do
    json.id conv.id
    json.title conv.title(@user)
    json.balance conv.balance(@user)
  end

  json.user_id @user.id

  json.users conv.users do |user|
    json.id user.id
    json.phone user.phone
    json.name user.name
  end

  json.transactions conv.transactions
end

