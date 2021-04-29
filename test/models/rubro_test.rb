# == Schema Information
#
# Table name: rubros
#
#  id          :bigint           not null, primary key
#  descripcion :string(255)
#  nombre      :string           not null
#
# Indexes
#
#  uk_nombre_rubro  (nombre) UNIQUE
#
require "test_helper"

class RubroTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
