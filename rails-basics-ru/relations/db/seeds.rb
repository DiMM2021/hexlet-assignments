# frozen_string_literal: true

statuses = %w[New In Progress Done]
statuses.each do |status_name|
  Status.create(name: status_name)
end

users = [
  { name: 'Alice' },
  { name: 'Bob' }
]
users.each do |user_data|
  User.create(user_data)
end
