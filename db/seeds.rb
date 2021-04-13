10.times do |n|
  name = Faker::Name.name
  email = "user#{n}@sample.com"
  password = "password"
  User.create!(name: name, email: email, password: password)
end

50.times do
  title = Faker::Book.title
  description = Faker::Lorem.sentence
  user_id = User.order("RANDOM()").first.id
  Blog.create!(title: title, description: description, user_id: user_id)
end
