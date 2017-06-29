json.conversation do
  json.id @conversation.id
  json.title @conversation.title(@user)
  json.balance @conversation.balance(@user)
end

json.user_id @user.id

json.users @conversation.users do |user|
  json.id user.id
  json.phone user.phone
  json.name user.name
end

json.transactions @conversation.transactions
