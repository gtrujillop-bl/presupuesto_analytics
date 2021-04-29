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
class Investigador < ApplicationRecord
  self.table_name = "investigadores"
  
  has_many :proyectos
end
