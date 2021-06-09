# == Schema Information
#
# Table name: programas
#
#  id            :bigint           not null, primary key
#  nombre        :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  facultades_id :bigint           not null
#
# Indexes
#
#  index_programas_on_facultades_id  (facultades_id)
#
# Foreign Keys
#
#  fk_rails_...  (facultades_id => facultades.id)
#
class Programa < ApplicationRecord
  belongs_to :facultad
end
