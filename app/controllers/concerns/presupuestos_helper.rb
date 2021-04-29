module PresupuestosHelper
  VALID_SEARCH_OPTIONS = %i[ 
    por_facultad 
    por_grupo 
    por_anio
    por_rubro
    por_proyecto
  ]

  def presupuestos_agg
    if params[:reporte].blank?
      @por_proyecto = Presupuesto.por_proyecto
      @presupuestos = Presupuesto.all
      return
    end

    option = params[:reporte].to_sym
    if !VALID_SEARCH_OPTIONS.include? option
      raise StandardError.new("Opción inválida: #{option}")
    end

    case option
    when :por_facultad
    when :por_grupo
    when :por_anio
    when :por_rubro
    end
  end 
end
