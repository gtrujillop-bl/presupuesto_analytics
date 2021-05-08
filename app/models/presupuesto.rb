require 'money'
# == Schema Information
#
# Table name: presupuestos
#
#  id             :bigint           not null, primary key
#  descripcion    :string
#  disponibilidad :decimal(, )      default(0.0)
#  egreso         :decimal(, )      default(0.0)
#  reserva        :decimal(, )      default(0.0)
#  valor_inicial  :decimal(, )
#  proyecto_id    :bigint
#  rubro_id       :bigint
#
# Indexes
#
#  fki_fk_presupuestos_proyectos      (proyecto_id)
#  fki_fk_presupuestos_rubros         (rubro_id)
#  index_presupuestos_on_proyecto_id  (proyecto_id)
#  index_presupuestos_on_rubro_id     (rubro_id)
#
# Foreign Keys
#
#  fk_presupuestos_proyectos  (proyecto_id => proyectos.id)
#  fk_presupuestos_rubros     (rubro_id => rubros.id)
#
class Presupuesto < ApplicationRecord
  belongs_to :rubro, foreign_key: :rubro_id
  belongs_to :proyecto, foreign_key: :proyecto_id

  validates :disponibilidad, numericality: true
  validates :egreso, numericality: true
  validates :reserva, numericality: true
  validates :valor_inicial, numericality: true

  # def self.por_proyecto
  #   sql = <<-SQL
  #     SELECT 
  #       pr.numero_proyecto,
  #       fa.nombre,
  #       pr.fecha_inicio,
  #       pr.fecha_fin,
  #       #{base_columns_for_presupuestos_report}
  #       FROM presupuestos pre
  #       INNER JOIN proyectos pr ON pr.id = pre.proyecto_id
  #       INNER JOIN facultades fa ON pr.facultad_id = fa.id
  #       GROUP BY pr.id, fa.id;
  #   SQL
  #   formatted_results(sql)
  # end

  def self.por_facultad
    sql_presupuestos = <<-SQL
      SELECT 
        fa.nombre AS nombre_facultad,
        #{base_columns_for_presupuestos_report}
        FROM presupuestos pre
        INNER JOIN proyectos pr ON pr.id = pre.proyecto_id
        INNER JOIN facultades fa ON pr.facultad_id = fa.id
        GROUP BY fa.id;
    SQL
    sql_presupuesto_inicial = <<-SQL
      SELECT
        fa.nombre AS nombre_facultad,
        SUM(pri.valor_inicial) AS presupuesto_inicial
        FROM presupuesto_inicial_proyectos pri
        INNER JOIN proyectos pr ON pr.id = pri.proyecto_id
        INNER JOIN facultades fa ON pr.facultad_id = fa.id
        GROUP BY fa.id
    SQL
    formatted_results(sql1: sql_presupuestos, sql2: sql_presupuesto_inicial, join_column: 'nombre_facultad')
  end

  def self.por_grupo
    sql_presupuestos = <<-SQL
      SELECT 
        gr.nombre AS nombre_grupo,
        #{base_columns_for_presupuestos_report}
        FROM presupuestos pre
        INNER JOIN proyectos pr ON pr.id = pre.proyecto_id
        INNER JOIN grupos gr ON gr.id = pr.grupo_id
        GROUP BY gr.id
    SQL

    sql_presupuesto_inicial = <<-SQL
      SELECT 
        gr.nombre AS nombre_grupo,
        SUM(pri.valor_inicial) AS presupuesto_inicial
        FROM presupuesto_inicial_proyectos pri
        INNER JOIN proyectos pr ON pr.id = pri.proyecto_id
        INNER JOIN grupos gr ON gr.id = pr.grupo_id
        GROUP BY gr.id
    SQL

    formatted_results(sql1: sql_presupuestos, sql2: sql_presupuesto_inicial, join_column: 'nombre_grupo')
  end

  def self.por_rubro
    sql_presupuestos = <<-SQL
      SELECT 
        ru.nombre AS nombre_rubro,
        #{base_columns_for_presupuestos_report}
        FROM presupuestos pre
        INNER JOIN rubros ru ON ru.id = pre.rubro_id
        GROUP BY ru.id
    SQL
    sql_presupuesto_inicial = <<-SQL
      SELECT 
        ru.nombre AS nombre_rubro,
        SUM(pri.valor_inicial) AS presupuesto_inicial
        FROM presupuesto_inicial_proyectos pri
        INNER JOIN rubros ru ON ru.id = pri.rubro_id
        GROUP BY ru.id
    SQL
    formatted_results(sql1: sql_presupuestos, sql2: sql_presupuesto_inicial, join_column: 'nombre_rubro')
  end

  def self.por_anio
    sql_presupuestos = <<-SQL
      SELECT 
        extract(year from pr.fecha_inicio) as anio_inicio,
        #{base_columns_for_presupuestos_report}
        FROM presupuestos pre
        INNER JOIN proyectos pr ON pr.id = pre.proyecto_id
        GROUP BY 1
    SQL
    
    sql_presupuesto_inicial = <<-SQL
      SELECT 
        extract(year from pr.fecha_inicio) as anio_inicio,
        SUM(pri.valor_inicial) AS presupuesto_inicial
        FROM presupuesto_inicial_proyectos pri
        INNER JOIN proyectos pr ON pr.id = pri.proyecto_id
        GROUP BY 1
    SQL
    formatted_results(sql1: sql_presupuestos, sql2: sql_presupuesto_inicial, join_column: 'anio_inicio')
  end
  

  private

  # sql1 es el parámetro de la consulta de presupuestos
  # sql2 es el parámetro de la consulta de valores iniciales
  # join_column es el campo por el que se van a unir sql1 y sql2
  def self.formatted_results(sql1: '', sql2: '', join_column: '')
    results_presupuesto_inicial = ActiveRecord::Base.connection.exec_query(sql2).to_a.map do |res|
      res['presupuesto_inicial'] = res['presupuesto_inicial'].to_f
      res
    end
    ActiveRecord::Base.connection.exec_query(sql1).to_a.map do |res|
      # TODO Refactor
      res['presupuesto_inicial'] = results_presupuesto_inicial.find do |rpi| 
        res[join_column].to_s.downcase == rpi[join_column].to_s.downcase 
      end['presupuesto_inicial']

      res['disponibilidad_total'] = res['disponibilidad_total'].to_f
      res['egreso_total'] = res['egreso_total'].to_f
      res['reserva_total'] = res['reserva_total'].to_f
      res
    end
  end

  def self.base_columns_for_presupuestos_report
    "SUM(pre.disponibilidad) AS disponibilidad_total,
     SUM(pre.egreso) AS egreso_total,
     SUM(pre.reserva) AS reserva_total"
  end
end
