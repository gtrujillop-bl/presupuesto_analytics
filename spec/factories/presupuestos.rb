FactoryBot.define do
  factory :presupuesto do
    descripcion { "Presupuesto de Prueba" }
    valor_inicial  { 1000000.0 }
    egreso { 500000.0 }
    reserva { 200000.0 }
    rubro { create(:rubro) }
    proyecto { create(:proyecto) }
  end
end
