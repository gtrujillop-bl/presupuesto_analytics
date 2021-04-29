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
require "test_helper"

class GrupoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
