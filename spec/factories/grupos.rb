FactoryBot.define do
  factory :grupo do
    nombre { Faker::Educator.unique.course_name }
    facultad { create(:facultad) }
  end
end
