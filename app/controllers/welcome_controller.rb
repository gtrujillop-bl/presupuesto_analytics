class WelcomeController < ApplicationController
  include WelcomeHelper

  before_action :data_lines_proyectos_totales, only: %i[ index ]
  before_action :data_radar_facultades_rubros_totales, only: %i[ index ]
  before_action :data_horizontal_chart_rubros_totales, only: %i[ index ]
  
  def index
    # Gráfica de Presupuestos dinámico por año
    @results_presupuesto = Presupuesto.por_anio
    
  end
  
  private

    def data_lines_proyectos_totales
      @results_proyectos = Presupuesto.count_proyecto_anio
      labels_proyectos = @results_proyectos.map { |proyecto| proyecto['anio_inicio'] }.compact.uniq
      datas_proyectos = @results_proyectos.map { |proyecto| proyecto['count'] }.compact.uniq
      color = chart_hex_color.sample
      @data_lines = {
        labels: labels_proyectos,
        datasets: [
          {
              label: "Número proyectos por año", 
              lineTension: 0,
              borderColor: color,
              data: datas_proyectos
          },
        ]
      }
    end

    def data_horizontal_chart_rubros_totales
      @results_presupuesto_rubro = Presupuesto.por_rubro
      rubro_inicial = []
      rubro_disponibilidad = []
      rubro_reserva = []
      rubro_egreso = []
      labels_rubros = @results_presupuesto_rubro.map { |rubro| rubro['nombre_rubro'] }.compact.uniq
      @results_presupuesto_rubro.map.with_index do |rubro, i|
        metricas_presupuestos.map.with_index do |metric, idx|
          case metric
          when 'presupuesto_inicial'
            rubro_inicial.push({ rubro['nombre_rubro'] => rubro[metric].to_i })
          when 'disponibilidad_total'
            rubro_disponibilidad.push({ rubro['nombre_rubro'] => rubro[metric].to_i })
          when 'reserva_total'
            rubro_reserva.push({ rubro['nombre_rubro'] => rubro[metric].to_i })
          when 'egreso_total'
            rubro_egreso.push({ rubro['nombre_rubro'] => rubro[metric].to_i })
          end
        end
      end
      rubro_inicial = rubro_inicial.sort { |a, b| b.values <=> a.values }
      rubro_disponibilidad = rubro_disponibilidad.sort { |a, b| b.values <=> a.values }
      rubro_reserva = rubro_reserva.sort { |a, b| b.values <=> a.values }
      rubro_egreso = rubro_egreso.sort { |a, b| b.values <=> a.values }
              
      @horizontal_inicial = {
        labels: rubro_inicial.map { |element| element.keys },
        datasets: [{
          axis: 'y',
          label: 'Valor inicial',
          data: rubro_inicial.flat_map { |element| element.values },
          fill: true,
          backgroundColor: chart_background_color,
          borderColor: chart_border_color,
          borderWidth: 1
        }]
      };
      @horizontal_disponibilidad = {
        labels: rubro_disponibilidad.map { |element| element.keys },
        datasets: [{
          axis: 'y',
          label: 'Disponibilidad',
          data: rubro_disponibilidad.flat_map { |element| element.values },
          fill: false,
          backgroundColor: chart_background_color,
          borderColor: chart_border_color,
          borderWidth: 1
        }]
      };
      @horizontal_reserva = {
        labels: rubro_reserva.map { |element| element.keys },
        datasets: [{
          axis: 'y',
          label: 'Reserva',
          data: rubro_reserva.flat_map { |element| element.values },
          fill: false,
          backgroundColor: chart_background_color,
          borderColor: chart_border_color,
          borderWidth: 1
        }]
      };
      @horizontal_egreso = {
        labels: rubro_egreso.map { |element| element.keys },
        datasets: [{
          axis: 'y',
          label: 'Egreso',
          data: rubro_egreso.flat_map { |element| element.values },
          fill: false,
          backgroundColor: chart_background_color,
          borderColor: chart_border_color,
          borderWidth: 1
        }]
      };
    end

    def data_radar_facultades_rubros_totales
      facultades = Facultad.all
      rubros = Rubro.all
      labels_rubros_radar = rubros.map { |rubro| rubro.nombre }.compact.uniq
      @all_datasets_init = []
      @all_datasets_disp = []
      @all_datasets_resv = []
      @all_datasets_egre = []
      
      facultad_rubro_inicial_hash = []
      facultad_rubro_disponibilidad_hash = []
      facultad_rubro_reserva_hash = []
      facultad_rubro_egreso_hash = []
      
      facultades.map.with_index do |facultad, i|
        # @results_facultad_rubro = Presupuesto.por_facultad_rubro(facultad.id)
        facultad_rubro_inicial_hash.push({ 'presupuesto_inicial' => facultad.nombre })
        facultad_rubro_disponibilidad_hash.push({ 'disponibilidad_total' => facultad.nombre })
        facultad_rubro_reserva_hash.push({ 'reserva_total' => facultad.nombre })
        facultad_rubro_egreso_hash.push({'egreso_total' => facultad.nombre })
        rubros_hash = Hash.new
        facultad_rubro_inicial = []
        facultad_rubro_disponibilidad = []
        facultad_rubro_reserva = []
        facultad_rubro_egreso = []
        rubros.map.with_index do |rubro, id|
          @results_facultad_rubro = Presupuesto.por_facultad_rubro(facultad.id, rubro.id)
          value_init = 0
          value_disp = 0
          value_resv = 0
          value_agre = 0
          # all_datasets.push({ facultad['nombre_facultad'] => rubro['nombre_rubro']})
          if @results_facultad_rubro.first.present?
            value_init = @results_facultad_rubro.first['presupuesto_inicial'].to_i
            value_disp = @results_facultad_rubro.first['disponibilidad_total'].to_i
            value_resv = @results_facultad_rubro.first['reserva_total'].to_i
            value_agre = @results_facultad_rubro.first['egreso_total'].to_i
          end
          facultad_rubro_inicial.push(value_init)
          facultad_rubro_disponibilidad.push(value_disp)
          facultad_rubro_reserva.push(value_resv)
          facultad_rubro_egreso.push(value_agre)
        end
        # facultades_hash[facultad.nombre] = rubros_hash

        @all_datasets_init.push({
          label: facultad.nombre, 
          lineTension: 0,
          backgroundColor: chart_background_color[i],
          borderColor: chart_border_color[i],
          data: facultad_rubro_inicial
        })
        @all_datasets_disp.push({
          label: facultad.nombre, 
          lineTension: 0,
          backgroundColor: chart_background_color[i],
          borderColor: chart_border_color[i],
          data: facultad_rubro_disponibilidad
        })
        @all_datasets_resv.push({
          label: facultad.nombre, 
          lineTension: 0,
          backgroundColor: chart_background_color[i],
          borderColor: chart_border_color[i],
          data: facultad_rubro_reserva
        })
        @all_datasets_egre.push({
          label: facultad.nombre, 
          lineTension: 0,
          backgroundColor: chart_background_color[i],
          borderColor: chart_border_color[i],
          data: facultad_rubro_egreso
        })
      end
      @radar_data_inicial = {
        labels: labels_rubros_radar,
        datasets: @all_datasets_init
      }
      @radar_data_disponibilidad = {
        labels: labels_rubros_radar,
        datasets: @all_datasets_disp
      }
      @radar_data_reserva = {
        labels: labels_rubros_radar,
        datasets: @all_datasets_resv
      }
      @radar_data_egreso = {
        labels: labels_rubros_radar,
        datasets: @all_datasets_egre
      }
    end

end