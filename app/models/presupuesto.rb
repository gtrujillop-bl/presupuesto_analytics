class Presupuesto < ApplicationRecord
  belongs_to :rubro, foreign_key: :rubro_id
  belongs_to :proyecto, foreign_key: :proyecto_id
end
