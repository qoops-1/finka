json.conversations @conversations do |conv|
  json.title conv.title(@user)
  json.balance conv.balance(@user)
  json.transaction conv.transaction
end