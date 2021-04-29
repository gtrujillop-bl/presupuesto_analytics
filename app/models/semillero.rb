# == Schema Information
#
# Table name: semilleros
#
#  id          :bigint           not null, primary key
#  nombre      :string
#  grupo_id    :bigint
#  descripcion :string(255)
#
class Semillero < ApplicationRecord
  belongs_to :grupo
end
