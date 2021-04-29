# == Schema Information
#
# Table name: grupos
#
#  id          :bigint           not null, primary key
#  nombre      :string
#  facultad_id :bigint
#
class Grupo < ApplicationRecord
  belongs_to :facultad, foreign_key: :facultad_id
  has_many :semilleros
  has_many :proyectos
end
