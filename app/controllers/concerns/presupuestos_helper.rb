module PresupuestosHelper
  VALID_SEARCH_OPTIONS = %i[ 
    por_facultad 
    por_grupo 
    por_anio
    por_rubro
    por_proyecto
  ]

  def metricas_presupuestos
    ['presupuesto_inicial', 'disponibilidad_total', 'reserva_total', 'egreso_total']
  end

  def metricas_colors
    ['#caf270', '#45c490', '#008d93', '#2e5468']
  end
  
  def stacked_bar_opts
    {
      stacked: true, 
      responsive: true, 
      scales: {
        xAxes: [{
          stacked: false,
          gridLines: {
            display: true,
          },
          scaleLabel: { 
            display: true, 
            fontSize: 10, 
          } 
        }],
        yAxes: [{
          stacked: false,
          ticks: {
            beginAtZero: true,
            callback: 'function(value, index, values) {
              return "$" + value.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, "$&,");
            }'
          },
          type: 'linear',
          scaleLabel: {

          }
        }]
      }, 
      legend: { position: 'bottom' },
      maintainAspectRatio: false,
      tooltips: {
        enabled: true,
        callbacks: {
          label: 'function(tooltipItem) {
            return "$" + tooltipItem.yLabel.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, "$&,");
          }'
        }
      }
    }
  end
  
  def presupuestos_agg
    if params[:reporte].blank?
      @presupuestos = Presupuesto.all
      return
    end

    option = params[:reporte].to_sym
    if !VALID_SEARCH_OPTIONS.include? option
      raise StandardError.new("Opción inválida: #{option}")
    end

    case option
    when :por_facultad
      data_presupuesto_facultades
    when :por_grupo
      data_presupuesto_grupos
    when :por_anio
      data_presupuesto_anios
    when :por_rubro
      data_presupuesto_rubros
    end
  end

  private

  # def data_presupuesto_proyectos
  #   @por_proyecto = Presupuesto.por_proyecto
  #   labels = @por_proyecto.map { |proyecto| proyecto['numero_proyecto'] }.compact.uniq
  #   datasets = metricas_presupuestos.map.with_index do |metric, idx|
  #     {}.tap do |data|
  #       data['label'] = metric.titleize
  #       data['backgroundColor'] = metricas_colors[idx]
  #       data['data'] = @por_proyecto.map { |proyecto| proyecto[metric] }
  #     end
  #   end
  #   @data = { labels: labels, datasets: datasets }
  # end

  def data_presupuesto_facultades
    @por_facultad = Presupuesto.por_facultad
    filter_option = params[:by]
    # binding.pry
    @options = @por_facultad.map { |elemento| [elemento['nombre_facultad'], elemento['id']] }
    labels = @por_facultad.map { |facultad| facultad['nombre_facultad'] }.compact.uniq
    datasets = metricas_presupuestos.map.with_index do |metric, idx|
      {}.tap do |data|
        data['label'] = metric.titleize
        data['backgroundColor'] = metricas_colors[idx]
        data['data'] = @por_facultad.map { |facultad| facultad[metric] }
      end
    end
    if params[:by].present?
      labels = @por_facultad.select{ |facultad| facultad['id'] == filter_option.to_i }
      labels = labels.map { |facultad| facultad['nombre_facultad'] }.compact.uniq
      #labels = @por_facultad.map { |facultad| facultad['nombre_facultad'] }.compact.uniq
      datasets = metricas_presupuestos.map.with_index do |metric, idx|
        {}.tap do |data|
          data['label'] = metric.titleize
          data['backgroundColor'] = metricas_colors[idx]
          data['data'] = @por_facultad.select{ |facultad| facultad['id'] == filter_option.to_i }.map { |facultad| facultad[metric] }
        end
      end
    end
    @data = { labels: labels, datasets: datasets }
  end

  def data_presupuesto_grupos
    @por_grupo = Presupuesto.por_grupo
    filter_option = params[:by]
    @options = @por_grupo.map { |elemento| [elemento['nombre_grupo'], elemento['id']] }
    labels = @por_grupo.map { |grupo| grupo['nombre_grupo'] }.compact.uniq
    datasets = metricas_presupuestos.map.with_index do |metric, idx|
      {}.tap do |data|
        data['label'] = metric.titleize
        data['backgroundColor'] = metricas_colors[idx]
        data['data'] = @por_grupo.map { |grupo| grupo[metric] }
      end
    end
    if params[:by].present?
      labels = @por_grupo.select{ |grupo| grupo['id'] == filter_option.to_i }
      labels = labels.map { |grupo| grupo['nombre_grupo'] }.compact.uniq
      #labels = @por_facultad.map { |facultad| facultad['nombre_facultad'] }.compact.uniq
      datasets = metricas_presupuestos.map.with_index do |metric, idx|
        {}.tap do |data|
          data['label'] = metric.titleize
          data['backgroundColor'] = metricas_colors[idx]
          data['data'] = @por_grupo.select{ |grupo| grupo['id'] == filter_option.to_i }.map { |grupo| grupo[metric] }
        end
      end
    end
    @data = { labels: labels, datasets: datasets }
  end

  def data_presupuesto_rubros
    @por_rubro = Presupuesto.por_rubro
    filter_option = params[:by]
    @options = @por_rubro.map { |elemento| [elemento['nombre_rubro'], elemento['id']] }
    labels = @por_rubro.map { |rubro| rubro['nombre_rubro'] }.compact.uniq
    datasets = metricas_presupuestos.map.with_index do |metric, idx|
      {}.tap do |data|
        data['label'] = metric.titleize
        data['backgroundColor'] = metricas_colors[idx]
        data['data'] = @por_rubro.map { |rubro| rubro[metric] }
      end
    end
    if params[:by].present?
      labels = @por_rubro.select{ |rubro| rubro['id'] == filter_option.to_i }
      labels = labels.map { |rubro| rubro['nombre_rubro'] }.compact.uniq
      #labels = @por_facultad.map { |facultad| facultad['nombre_facultad'] }.compact.uniq
      datasets = metricas_presupuestos.map.with_index do |metric, idx|
        {}.tap do |data|
          data['label'] = metric.titleize
          data['backgroundColor'] = metricas_colors[idx]
          data['data'] = @por_rubro.select{ |rubro| rubro['id'] == filter_option.to_i }.map { |rubro| rubro[metric] }
        end
      end
    end
    @data = { labels: labels, datasets: datasets }
  end

  def data_presupuesto_anios
    @por_anio = Presupuesto.por_anio
    filter_option = params[:by]

    labels = @por_anio.map { |anio| anio['anio_inicio'] }.compact.uniq
    @options = labels
    datasets = metricas_presupuestos.map.with_index do |metric, idx|
      {}.tap do |data|
        data['label'] = metric.titleize
        data['backgroundColor'] = metricas_colors[idx]
        data['data'] = @por_anio.map { |anio| anio[metric] }
      end
    end
    if params[:by].present?
      labels = @por_anio.select{ |anio| anio['anio_inicio'] == filter_option.to_i }
      labels = labels.map { |anio| anio['anio_inicio'] }.compact.uniq
      datasets = metricas_presupuestos.map.with_index do |metric, idx|
        {}.tap do |data|
          data['label'] = metric.titleize
          data['backgroundColor'] = metricas_colors[idx]
          data['data'] = @por_anio.select{ |anio| anio['anio_inicio'] == filter_option.to_i }.map{ |anio| anio[metric] }
        end
      end
    end
    @data = { labels: labels, datasets: datasets }
  end
  
  def report_by
    reporte = params[:reporte]
    filter_option = params[:by]

    if reporte === "por_facultad"
      @reports = Presupuesto.joins("INNER JOIN proyectos ON proyectos.id = presupuestos.proyecto_id").where("proyectos.facultad_id = ?", filter_option)
    elsif reporte == "por_grupo" and params[:by].present?
      @reports = Presupuesto.joins("INNER JOIN proyectos ON proyectos.id = presupuestos.proyecto_id").where("proyectos.grupo_id = ?", filter_option)
    elsif reporte == "por_semillero" and params[:by].present?
      @reports = Presupuesto.joins("INNER JOIN proyectos ON proyectos.id = presupuestos.proyecto_id").where("proyectos.semillero_id = ?", filter_option)
    elsif reporte == "por_anio" and params[:by].present?
        @reports = Presupuesto.joins("INNER JOIN proyectos ON proyectos.id = presupuestos.proyecto_id").where("extract(year from proyectos.fecha_inicio) = ?", filter_option)
    elsif reporte == "por_rubro" and params[:by].present?
      @reports = Presupuesto.where("presupuestos.rubro_id = ?", filter_option)
    elsif reporte == "por_proyecto" and params[:by].present?
      @reports = Presupuesto.where("presupuestos.proyecto_id = ?", filter_option)
    else
      @reports = Presupuesto.all
    end

  end
end
