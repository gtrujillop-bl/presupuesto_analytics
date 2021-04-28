json.extract! presupuesto, :id, :rubro_id, :proyecto_id, :valor_inicial, :disponibilidad, :descripcion, :egreso, :reserva, :created_at, :updated_at
json.url presupuesto_url(presupuesto, format: :json)
