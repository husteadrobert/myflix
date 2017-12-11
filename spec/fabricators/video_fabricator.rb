Fabricator(:video) do
  title { Faker::Book.title }
  description { Faker::FamilyGuy.quote }
end