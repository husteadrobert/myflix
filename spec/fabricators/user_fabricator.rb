Fabricator(:user) do
  name { Faker::Name.name }
  email_address { Faker::Internet.email }
  password "secret"
end