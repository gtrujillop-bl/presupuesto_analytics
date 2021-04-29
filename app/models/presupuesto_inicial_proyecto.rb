# == Schema Information
#
# Table name: presupuesto_inicial_proyectos
#
#  id            :bigint           not null, primary key
#  rubro_id      :bigint           not null
#  proyecto_id   :bigint           not null
#  descripcion   :string           not null
#  valor_inicial :decimal(, )      not null
#
class PresupuestoInicialProyecto < ApplicationRecord
  belongs_to :rubro
  belongs_to :proyecto
end
