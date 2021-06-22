module PresupuestosHelper
  VALID_SEARCH_OPTIONS = %i[ 
    por_facultad 
    por_grupo 
    por_anio
    por_rubro
    por_proyecto
    por_programa
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
      @pagy, @presupuestos = pagy(Presupuesto.all)
      totales = Presupuesto.all
      calc_totals(totales)
      return
    end

    option = params[:reporte].to_sym
    if !VALID_SEARCH_OPTIONS.include? option
      raise StandardError.new("Opción inválida: #{option}")
    end

    case option
    when :por_facultad
      data_presupuesto_facultades
    when :por_programa
      data_presupuesto_programas
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

  def calc_totals(totales)
    # Se optienen las sumatoria de Totales 
    @total_valor_inicial = totales.map(&:valor_inicial).compact.reduce(&:+)
    @total_disponibilidad = totales.map(&:disponibilidad).compact.reduce(&:+)
    @total_egreso = totales.map(&:egreso).compact.reduce(&:+)
    @total_reserva = totales.map(&:reserva).compact.reduce(&:+)
  end

  def set_pagination
    # @report_grid_data Recibe todos los datos que se van a presentar en la grilla
    @pagy, @report_grid_data = pagy(Presupuesto.grid_data(report_type: params[:reporte], filter_option: params[:by]))
  end

  def data_presupuesto_facultades
    @por_facultad = Presupuesto.por_facultad
    @filter_option = params[:by]
    @report = params[:reporte]
    # @report_grid_data Recibe todos los datos que se van a presentar en la grilla
    # @options Recibe las opciones de filtrados mostradas en el select dropdown
    @pagy, @report_grid_data = pagy(Presupuesto.grid_data(report_type: params[:reporte], filter_option: @filter_option))
    @options = @por_facultad.map { |elemento| [elemento['nombre_facultad'], elemento['id']] }

    # Se optienen las sumatoria de Totales 
    calc_totals(Presupuesto.grid_data(report_type: params[:reporte], filter_option: @filter_option))
    # si recibe parametros de filtrado, extrae los datos según la opción de filtrado seleccionada, en caso contrario devuelve todos los resultados
    if params[:by].present?
      labels = @por_facultad.select{ |facultad| facultad['id'] == @filter_option.to_i }
      labels = labels.map { |facultad| facultad['nombre_facultad'] }.compact.uniq
      #labels = @por_facultad.map { |facultad| facultad['nombre_facultad'] }.compact.uniq
      datasets = metricas_presupuestos.map.with_index do |metric, idx|
        {}.tap do |data|
          data['label'] = metric.titleize
          data['backgroundColor'] = metricas_colors[idx]
          data['data'] = @por_facultad.select{ |facultad| facultad['id'] == @filter_option.to_i }.map { |facultad| facultad[metric] }
        end
      end
    else
      labels = @por_facultad.map { |facultad| facultad['nombre_facultad'] }.compact.uniq
      datasets = metricas_presupuestos.map.with_index do |metric, idx|
        {}.tap do |data|
          data['label'] = metric.titleize
          data['backgroundColor'] = metricas_colors[idx]
          data['data'] = @por_facultad.map { |facultad| facultad[metric] }
        end
      end
    end
    @data = { labels: labels, datasets: datasets }
  end

  def data_presupuesto_programas
    @por_programa = Presupuesto.por_programa
    @filter_option = params[:by]
    @report = params[:reporte]
    # @report_grid_data Recibe todos los datos que se van a presentar en la grilla
    # @options Recibe las opciones de filtrados mostradas en el select dropdown
    @pagy, @report_grid_data = pagy(Presupuesto.grid_data(report_type: params[:reporte], filter_option: @filter_option))
    @options = @por_programa.map { |elemento| [elemento['nombre_programa'], elemento['id']] }

    # Se optienen las sumatoria de Totales 
    calc_totals(Presupuesto.grid_data(report_type: params[:reporte], filter_option: @filter_option))
    # si recibe parametros de filtrado, extrae los datos según la opción de filtrado seleccionada, en caso contrario devuelve todos los resultados
    if params[:by].present?
      labels = @por_programa.select{ |programa| programa['id'] == @filter_option.to_i }
      labels = labels.map { |programa| programa['nombre_programa'] }.compact.uniq
      #labels = @por_programa.map { |programa| programa['nombre_programa'] }.compact.uniq
      datasets = metricas_presupuestos.map.with_index do |metric, idx|
        {}.tap do |data|
          data['label'] = metric.titleize
          data['backgroundColor'] = metricas_colors[idx]
          data['data'] = @por_programa.select{ |programa| programa['id'] == @filter_option.to_i }.map { |programa| programa[metric] }
        end
      end
    else
      labels = @por_programa.map { |programa| programa['nombre_programa'] }.compact.uniq
      datasets = metricas_presupuestos.map.with_index do |metric, idx|
        {}.tap do |data|
          data['label'] = metric.titleize
          data['backgroundColor'] = metricas_colors[idx]
          data['data'] = @por_programa.map { |programa| programa[metric] }
        end
      end
    end
    @data = { labels: labels, datasets: datasets }
  end

  def data_presupuesto_grupos
    @por_grupo = Presupuesto.por_grupo
    @filter_option = params[:by]
    @report = params[:reporte]
    set_pagination
    # @options Recibe las opciones de filtrados mostradas en el select dropdown
    @options = @por_grupo.map { |elemento| [elemento['nombre_grupo'], elemento['id']] }

    # Se optienen las sumatoria de Totales 
    calc_totals(Presupuesto.grid_data(report_type: params[:reporte], filter_option: @filter_option))
    # si recibe parametros de filtrado, extrae los datos según la opción de filtrado seleccionada, en caso contrario devuelve todos los resultados
    if params[:by].present?
      labels = @por_grupo.select{ |grupo| grupo['id'] == @filter_option.to_i }
      labels = labels.map { |grupo| grupo['nombre_grupo'] }.compact.uniq
      #labels = @por_facultad.map { |facultad| facultad['nombre_facultad'] }.compact.uniq
      datasets = metricas_presupuestos.map.with_index do |metric, idx|
        {}.tap do |data|
          data['label'] = metric.titleize
          data['backgroundColor'] = metricas_colors[idx]
          data['data'] = @por_grupo.select{ |grupo| grupo['id'] == @filter_option.to_i }.map { |grupo| grupo[metric] }
        end
      end
    else
      labels = @por_grupo.map { |grupo| grupo['nombre_grupo'] }.compact.uniq
      datasets = metricas_presupuestos.map.with_index do |metric, idx|
        {}.tap do |data|
          data['label'] = metric.titleize
          data['backgroundColor'] = metricas_colors[idx]
          data['data'] = @por_grupo.map { |grupo| grupo[metric] }
        end
      end
    end
    @data = { labels: labels, datasets: datasets }
  end

  def data_presupuesto_rubros
    @por_rubro = Presupuesto.por_rubro
    @filter_option = params[:by]
    @report = params[:reporte]
    set_pagination
    # @options Recibe las opciones de filtrados mostradas en el select dropdown
    @options = @por_rubro.map { |elemento| [elemento['nombre_rubro'], elemento['id']] }

    # Se optienen las sumatoria de Totales 
    calc_totals(Presupuesto.grid_data(report_type: params[:reporte], filter_option: @filter_option))
    # si recibe parametros de filtrado, extrae los datos según la opción de filtrado seleccionada, en caso contrario devuelve todos los resultados
    if params[:by].present?
      labels = @por_rubro.select{ |rubro| rubro['id'] == @filter_option.to_i }
      labels = labels.map { |rubro| rubro['nombre_rubro'] }.compact.uniq
      #labels = @por_facultad.map { |facultad| facultad['nombre_facultad'] }.compact.uniq
      datasets = metricas_presupuestos.map.with_index do |metric, idx|
        {}.tap do |data|
          data['label'] = metric.titleize
          data['backgroundColor'] = metricas_colors[idx]
          data['data'] = @por_rubro.select{ |rubro| rubro['id'] == @filter_option.to_i }.map { |rubro| rubro[metric] }
        end
      end
    else
      labels = @por_rubro.map { |rubro| rubro['nombre_rubro'] }.compact.uniq
      datasets = metricas_presupuestos.map.with_index do |metric, idx|
        {}.tap do |data|
          data['label'] = metric.titleize
          data['backgroundColor'] = metricas_colors[idx]
          data['data'] = @por_rubro.map { |rubro| rubro[metric] }
        end
      end
    end
    @data = { labels: labels, datasets: datasets }
  end

  def data_presupuesto_anios
    @por_anio = Presupuesto.por_anio
    @filter_option = params[:by]
    @report = params[:reporte]
    set_pagination
    # @options Recibe las opciones de filtrados mostradas en el select dropdown
    labels = @por_anio.map { |anio| anio['anio_inicio'] }.compact.uniq
    @options = labels

    # Se optienen las sumatoria de Totales 
    calc_totals(Presupuesto.grid_data(report_type: params[:reporte], filter_option: @filter_option))
    # si recibe parametros de filtrado, extrae los datos según la opción de filtrado seleccionada, en caso contrario devuelve todos los resultados
    if params[:by].present?
      labels = @por_anio.select{ |anio| anio['anio_inicio'] == @filter_option.to_i }
      labels = labels.map { |anio| anio['anio_inicio'] }.compact.uniq
      datasets = metricas_presupuestos.map.with_index do |metric, idx|
        {}.tap do |data|
          data['label'] = metric.titleize
          data['backgroundColor'] = metricas_colors[idx]
          data['data'] = @por_anio.select{ |anio| anio['anio_inicio'] == @filter_option.to_i }.map{ |anio| anio[metric] }
        end
      end
    else
      datasets = metricas_presupuestos.map.with_index do |metric, idx|
        {}.tap do |data|
          data['label'] = metric.titleize
          data['backgroundColor'] = metricas_colors[idx]
          data['data'] = @por_anio.map { |anio| anio[metric] }
        end
      end
    end
    @data = { labels: labels, datasets: datasets }
  end
  
end
