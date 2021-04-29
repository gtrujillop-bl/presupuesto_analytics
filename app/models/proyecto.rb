# == Schema Information
#
# Table name: proyectos
#
#  id              :bigint           not null, primary key
#  fecha_fin       :date             not null
#  fecha_inicio    :date
#  nombre          :string
#  numero_proyecto :string           not null
#  facultad_id     :bigint
#  grupo_id        :bigint
#  investigador_id :bigint
#  semillero_id    :bigint
#
# Indexes
#
#  fki_fk_proyectos_facultades      (facultad_id)
#  fki_fk_proyectos_grupos          (grupo_id)
#  fki_fk_proyectos_investigadores  (investigador_id)
#  fki_fk_proyectos_semilleros      (semillero_id)
#
# Foreign Keys
#
#  fk_proyectos_facultades      (facultad_id => facultades.id)
#  fk_proyectos_grupos          (grupo_id => grupos.id)
#  fk_proyectos_investigadores  (investigador_id => investigadores.id)
#  fk_proyectos_semilleros      (semillero_id => semilleros.id)
#
class Proyecto < ApplicationRecord
  belongs_to :facultad, foreign_key: :facultad_id
  belongs_to :grupo, foreign_key: :grupo_id
  belongs_to :semillero, foreign_key: :semillero_id
  belongs_to :investigador, foreign_key: :investigador_id
  has_many :rubros, through: :presupuestos

  validates :fecha_inicio, presence: true
  validates :nombre, presence: true
  validates :numero_proyecto, presence: true
end
