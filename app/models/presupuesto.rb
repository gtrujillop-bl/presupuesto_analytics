# == Schema Information
#
# Table name: presupuestos
#
#  id             :bigint           not null, primary key
#  rubro_id       :bigint
#  proyecto_id    :bigint
#  valor_inicial  :decimal(, )
#  disponibilidad :decimal(, )      default(0.0)
#  descripcion    :string
#  egreso         :decimal(, )      default(0.0)
#  reserva        :decimal(, )      default(0.0)
#
class Presupuesto < ApplicationRecord
  belongs_to :rubro, foreign_key: :rubro_id
  belongs_to :proyecto, foreign_key: :proyecto_id
end
