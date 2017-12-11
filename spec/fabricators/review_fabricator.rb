Fabricator(:review) do
  user
  video
  body { Faker::Lorem.paragraph(2) }
  rating 3
end
