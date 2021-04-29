# == Schema Information
#
# Table name: presupuestos
#
#  id             :bigint           not null, primary key
#  rubro_id       :bigint
#  proyecto_id    :bigint
#  valor_inicial  :decimal(, )
#  disponibilidad :decimal(, )      default(0.0)
#  descripcion    :string
#  egreso         :decimal(, )      default(0.0)
#  reserva        :decimal(, )      default(0.0)
#
require "test_helper"

class PresupuestoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
