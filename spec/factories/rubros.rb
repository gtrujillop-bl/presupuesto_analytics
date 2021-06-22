FactoryBot.define do
  factory :rubro do
    descripcion { 'Rubro de Prueba' }
    nombre { Faker::Company.unique.type }
  end
end
