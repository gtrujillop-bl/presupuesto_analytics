# == Schema Information
#
# Table name: rubros
#
#  id          :bigint           not null, primary key
#  nombre      :string           not null
#  descripcion :string(255)
#
class Rubro < ApplicationRecord
  has_many :proyectos, through: :presupuestos
end
