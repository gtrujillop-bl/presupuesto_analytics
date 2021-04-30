module PresupuestosHelper
  VALID_SEARCH_OPTIONS = %i[ 
    por_facultad 
    por_grupo 
    por_anio
    por_rubro
    por_proyecto
  ]

  def stack_colors
    
  end

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
          stacked: true,
          gridLines: {
            display: false,
          }
        }],
        yAxes: [{
          stacked: true,
          ticks: {
            beginAtZero: true,
          },
          type: 'linear',
        }]
      }, 
      legend: { position: 'bottom' },
      maintainAspectRatio: false
    }
  end
  
  def presupuestos_agg
    if params[:reporte].blank?
      @por_proyecto = Presupuesto.por_proyecto
      labels = @por_proyecto.map { |proyecto| proyecto['numero_proyecto'] }.compact.uniq
      datasets = metricas_presupuestos.map.with_index do |metric, idx|
        {}.tap do |data|
          data['label'] = metric.titleize
          data['backgroundColor'] = metricas_colors[idx]
          data['data'] = @por_proyecto.map { |proyecto| proyecto[metric] }
        end
      end
      @data = { labels: labels, datasets: datasets }
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
