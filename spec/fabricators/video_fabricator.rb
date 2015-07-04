Fabricator(:video) do
  title { Faker::Lorem.sentence(5) }
  description {Faker::Lorem.paragraph(2) }
end