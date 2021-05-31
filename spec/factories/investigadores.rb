FactoryBot.define do
  factory :investigador do
    nombres { Faker::Name.first_name }
    apellidos { Faker::Name.last_name }
    cedula { Faker::Number.unique.number(digits: 8)  }
  end
end
