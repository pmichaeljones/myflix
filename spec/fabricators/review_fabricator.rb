Fabricator(:review) do
  body { Faker::Lorem.paragraph(1) }
  rating { rand(6) }
end
