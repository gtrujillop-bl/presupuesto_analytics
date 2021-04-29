# == Schema Information
#
# Table name: presupuestos
#
#  id             :bigint           not null, primary key
#  descripcion    :string
#  disponibilidad :decimal(, )      default(0.0)
#  egreso         :decimal(, )      default(0.0)
#  reserva        :decimal(, )      default(0.0)
#  valor_inicial  :decimal(, )
#  proyecto_id    :bigint
#  rubro_id       :bigint
#
# Indexes
#
#  fki_fk_presupuestos_proyectos      (proyecto_id)
#  fki_fk_presupuestos_rubros         (rubro_id)
#  index_presupuestos_on_proyecto_id  (proyecto_id)
#  index_presupuestos_on_rubro_id     (rubro_id)
#
# Foreign Keys
#
#  fk_presupuestos_proyectos  (proyecto_id => proyectos.id)
#  fk_presupuestos_rubros     (rubro_id => rubros.id)
#
require "test_helper"

class PresupuestoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
