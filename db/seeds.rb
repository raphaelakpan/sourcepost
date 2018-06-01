# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# users = [
#   {
#     name: 'Mercy Oseni',
#     email: 'mercy.oseni@andela.com'
#   },
#   {
#     name: 'Raphael Akpan',
#     email: 'raphael.akpan@andela.com'
#   }
# ]
#
# users.each do |user|
#   User.create!(
#     name: user.name,
#     email: user.email,
#     password: '123456'
#   )
# end


100.times do |n|
  User.create!(
    name: Faker::Name.name,
    email: "user#{n+1}@example.com",
    password: "123456"
  )
end
