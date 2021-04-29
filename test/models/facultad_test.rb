# == Schema Information
#
# Table name: facultades
#
#  id     :bigint           not null, primary key
#  nombre :string
#
# Indexes
#
#  uk_nombre_facultad  (nombre) UNIQUE
#
require "test_helper"

class FacultadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
