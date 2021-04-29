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
class Facultad < ApplicationRecord
  self.table_name = "facultades"
  
  has_many :grupos
  has_many :proyectos
end
