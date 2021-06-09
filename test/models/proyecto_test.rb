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
#  programa_id     :bigint
#  semillero_id    :bigint
#
# Indexes
#
#  fki_fk_proyectos_facultades         (facultad_id)
#  fki_fk_proyectos_grupos             (grupo_id)
#  fki_fk_proyectos_investigadores     (investigador_id)
#  fki_fk_proyectos_semilleros         (semillero_id)
#  index_proyectos_on_facultad_id      (facultad_id)
#  index_proyectos_on_grupo_id         (grupo_id)
#  index_proyectos_on_investigador_id  (investigador_id)
#  index_proyectos_on_programa_id      (programa_id)
#  index_proyectos_on_semillero_id     (semillero_id)
#
# Foreign Keys
#
#  fk_proyectos_facultades      (facultad_id => facultades.id)
#  fk_proyectos_grupos          (grupo_id => grupos.id)
#  fk_proyectos_investigadores  (investigador_id => investigadores.id)
#  fk_proyectos_semilleros      (semillero_id => semilleros.id)
#  fk_rails_...                 (programa_id => programas.id)
#
require "test_helper"

class ProyectoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
