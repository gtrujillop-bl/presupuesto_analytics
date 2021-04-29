# == Schema Information
#
# Table name: rubros
#
#  id          :bigint           not null, primary key
#  descripcion :string(255)
#  nombre      :string           not null
#
# Indexes
#
#  uk_nombre_rubro  (nombre) UNIQUE
#
class Rubro < ApplicationRecord
  has_many :proyectos, through: :presupuestos
end
