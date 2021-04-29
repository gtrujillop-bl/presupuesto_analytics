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
require "test_helper"

class ProyectoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
