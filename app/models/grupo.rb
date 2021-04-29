# == Schema Information
#
# Table name: grupos
#
#  id                                        :bigint           not null, primary key
#  nombre                                    :string
#  facultad_id(Identificador de la facultad) :bigint
#
# Indexes
#
#  fki_fk_grupos_facultades  (facultad_id)
#
# Foreign Keys
#
#  fk_grupos_facultades  (facultad_id => facultades.id) ON DELETE => cascade ON UPDATE => cascade
#
class Grupo < ApplicationRecord
  belongs_to :facultad, foreign_key: :facultad_id
  has_many :semilleros
  has_many :proyectos

  validates :nombre, presence: true
end
