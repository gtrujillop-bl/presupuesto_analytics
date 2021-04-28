class Proyecto < ApplicationRecord
  belongs_to :facultad, foreign_key: :facultad_id
  belongs_to :grupo, foreign_key: :grupo_id
  belongs_to :semillero, foreign_key: :semillero_id
  belongs_to :investigador, foreign_key: :investigador_id
  has_many :rubros, through: :presupuestos
end
