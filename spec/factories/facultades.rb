FactoryBot.define do
  factory :facultad do
    nombre { Faker::Educator.degree }
  end
end
