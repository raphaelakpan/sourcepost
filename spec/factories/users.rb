FactoryBot.define do
  factory :user do
    name 'Sample User'
    email 'sample.user@example.com'
    password 'foobar'
    password_confirmation 'foobar'
  end
end
