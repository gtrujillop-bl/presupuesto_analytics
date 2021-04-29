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
#  fki_fk_presupuestos_proyectos  (proyecto_id)
#  fki_fk_presupuestos_rubros     (rubro_id)
#
# Foreign Keys
#
#  fk_presupuestos_proyectos  (proyecto_id => proyectos.id)
#  fk_presupuestos_rubros     (rubro_id => rubros.id)
#
class Presupuesto < ApplicationRecord
  belongs_to :rubro, foreign_key: :rubro_id
  belongs_to :proyecto, foreign_key: :proyecto_id

  validates :disponibilidad, numericality: true
  validates :egreso, numericality: true
  validates :reserva, numericality: true
  validates :valor_inicial, numericality: true
end
