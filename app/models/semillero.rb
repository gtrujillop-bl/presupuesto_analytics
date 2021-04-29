# == Schema Information
#
# Table name: semilleros
#
#  id          :bigint           not null, primary key
#  descripcion :string(255)
#  nombre      :string
#  grupo_id    :bigint
#
# Indexes
#
#  fki_fk_semilleros_grupos      (grupo_id)
#  index_semilleros_on_grupo_id  (grupo_id)
#
# Foreign Keys
#
#  fk_semilleros_grupos  (grupo_id => grupos.id)
#
class Semillero < ApplicationRecord
  belongs_to :grupo
end
