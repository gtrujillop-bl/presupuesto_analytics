class Rubro < ApplicationRecord
  has_many :proyectos, through: :presupuestos
end
