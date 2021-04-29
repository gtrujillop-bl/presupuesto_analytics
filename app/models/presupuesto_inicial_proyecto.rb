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
#  fki_fk_presupuesto_inicial_proyectos  (proyecto_id)
#  uk_rubro_proyecto                     (rubro_id,proyecto_id) UNIQUE
#
# Foreign Keys
#
#  fk_presupuesto_inicial_proyectos  (proyecto_id => proyectos.id)
#  fk_presupuestos_rubros            (rubro_id => rubros.id)
#
class PresupuestoInicialProyecto < ApplicationRecord
  belongs_to :rubro
  belongs_to :proyecto
end
