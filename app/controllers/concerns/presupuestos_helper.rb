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
    labels = @por_facultad.map { |facultad| facultad['nombre_facultad'] }.compact.uniq
    datasets = metricas_presupuestos.map.with_index do |metric, idx|
      {}.tap do |data|
        data['label'] = metric.titleize
        data['backgroundColor'] = metricas_colors[idx]
        data['data'] = @por_facultad.map { |facultad| facultad[metric] }
      end
    end
    @data = { labels: labels, datasets: datasets }
  end

  def data_presupuesto_grupos
    @por_grupo = Presupuesto.por_grupo
    labels = @por_grupo.map { |grupo| grupo['nombre_grupo'] }.compact.uniq
    datasets = metricas_presupuestos.map.with_index do |metric, idx|
      {}.tap do |data|
        data['label'] = metric.titleize
        data['backgroundColor'] = metricas_colors[idx]
        data['data'] = @por_grupo.map { |grupo| grupo[metric] }
      end
    end
    @data = { labels: labels, datasets: datasets }
  end

  def data_presupuesto_rubros
    @por_rubro = Presupuesto.por_rubro
    labels = @por_rubro.map { |rubro| rubro['nombre_rubro'] }.compact.uniq
    datasets = metricas_presupuestos.map.with_index do |metric, idx|
      {}.tap do |data|
        data['label'] = metric.titleize
        data['backgroundColor'] = metricas_colors[idx]
        data['data'] = @por_rubro.map { |rubro| rubro[metric] }
      end
    end
    @data = { labels: labels, datasets: datasets }
  end

  def data_presupuesto_anios
    @por_anio = Presupuesto.por_anio
    reporte = params[:reporte].to_sym
    filter_option = params[:by]

    labels = @por_anio.map { |anio| anio['anio_inicio'] }.compact.uniq
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
    reporte = params[:reporte].to_sym
    filter_option = params[:by]
    @reports = Presupuesto.joins("INNER JOIN proyectos ON proyectos.id = presupuestos.proyecto_id").where("extract(year from proyectos.fecha_inicio) = ?", filter_option)
  end
end
