# == Schema Information
#
# Table name: investigadores
#
#  id        :bigint           not null, primary key
#  apellidos :string
#  cedula    :integer
#  nombres   :string
#
# Indexes
#
#  uk_cedula_investigador             (cedula) UNIQUE
#  uk_nombres_apellidos_investigador  (nombres,apellidos) UNIQUE
#
require "test_helper"

class InvestigadorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
