FactoryBot.define do
  factory :presupuesto_inicial_proyecto do
    descripcion { "Presupuesto Inicial de Prueba" }
    valor_inicial  { 1000000.0 }
    rubro { create(:rubro) }
    proyecto { create(:proyecto) }
  end
end
