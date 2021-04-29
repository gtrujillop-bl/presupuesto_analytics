# == Schema Information
#
# Table name: presupuesto_inicial_proyectos
#
#  id            :bigint           not null, primary key
#  descripcion   :string           not null
#  valor_inicial :decimal(, )      not null
#  proyecto_id   :bigint           not null
#  rubro_id      :bigint           not null
#
# Indexes
#
#  fki_fk_presupuesto_inicial_proyectos                (proyecto_id)
#  index_presupuesto_inicial_proyectos_on_proyecto_id  (proyecto_id)
#  index_presupuesto_inicial_proyectos_on_rubro_id     (rubro_id)
#  uk_rubro_proyecto                                   (rubro_id,proyecto_id) UNIQUE
#
# Foreign Keys
#
#  fk_presupuesto_inicial_proyectos  (proyecto_id => proyectos.id)
#  fk_presupuestos_rubros            (rubro_id => rubros.id)
#
require "test_helper"

class PresupuestoInicialProyectoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
