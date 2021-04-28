class Facultad < ApplicationRecord
  has_many :grupos
  has_many :proyectos
end
