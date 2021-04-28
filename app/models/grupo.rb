class Grupo < ApplicationRecord
  belongs_to :facultad, foreign_key: :facultad_id
  has_many :semilleros
  has_many :proyectos
end
