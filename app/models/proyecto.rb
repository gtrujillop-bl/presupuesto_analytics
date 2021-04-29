# == Schema Information
#
# Table name: proyectos
#
#  id              :bigint           not null, primary key
#  nombre          :string
#  fecha_inicio    :date
#  fecha_fin       :date             not null
#  facultad_id     :bigint
#  grupo_id        :bigint
#  semillero_id    :bigint
#  investigador_id :bigint
#  numero_proyecto :string           not null
#
class Proyecto < ApplicationRecord
  belongs_to :facultad, foreign_key: :facultad_id
  belongs_to :grupo, foreign_key: :grupo_id
  belongs_to :semillero, foreign_key: :semillero_id
  belongs_to :investigador, foreign_key: :investigador_id
  has_many :rubros, through: :presupuestos
end
