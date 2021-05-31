FactoryBot.define do
  factory :proyecto do
    fecha_inicio { Time.now }
    fecha_fin  { Time.now + 3.days }
    nombre { 'Proyecto de Prueba' }
    numero_proyecto { '400000123-12' }
    facultad { create(:facultad) }
    grupo { create(:grupo) }
    investigador { create(:investigador) }
  end
end
