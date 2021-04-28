json.extract! proyecto, :id, :nombre, :fecha_inicio, :fecha_fin, :facultad_id, :grupo_id, :semillero_id, :investigador_id, :numero_proyecto, :created_at, :updated_at
json.url proyecto_url(proyecto, format: :json)
