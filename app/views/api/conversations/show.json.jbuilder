json.id @conversation.id
json.balance @conversation.balance(@user)

json.companions @conversation.users.select { |user| user.id != @user.id }

json.transactions @conversation.transactions
