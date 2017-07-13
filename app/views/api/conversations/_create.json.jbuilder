json.id conversation.id
json.balance conversation.balance(user)

json.companions conversation.users.select { |member| user.id != member.id }

json.transactions conversation.transactions