json.(@conversation, :title, :balance)

json.current_user_id @user.id

json.users @conversation.users do |user|
  json.id user.id
  json.phone user.phone
  json.name user.name
end

json.transactions @conversation.transactions