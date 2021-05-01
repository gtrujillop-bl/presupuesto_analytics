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

  def self.por_proyecto
    sql = <<-SQL
      SELECT 
        pr.numero_proyecto,
        fa.nombre,
        pr.fecha_inicio,
        pr.fecha_fin,
        #{base_columns_for_report}
        FROM presupuestos pre
        INNER JOIN proyectos pr ON pr.id = pre.proyecto_id
        INNER JOIN facultades fa ON pr.facultad_id = fa.id
        GROUP BY pr.id, fa.id;
    SQL
    formatted_results(sql)
  end

  def self.por_facultad
    sql = <<-SQL
      SELECT 
        fa.nombre AS nombre_facultad,
        #{base_columns_for_report}
        FROM presupuestos pre
        INNER JOIN proyectos pr ON pr.id = pre.proyecto_id
        INNER JOIN facultades fa ON pr.facultad_id = fa.id
        GROUP BY fa.id;
    SQL
    formatted_results(sql)
  end

  def self.por_grupo
    sql = <<-SQL
      SELECT 
        gr.nombre AS nombre_grupo,
        #{base_columns_for_report}
        FROM presupuestos pre
        INNER JOIN proyectos pr ON pr.id = pre.proyecto_id
        INNER JOIN grupos gr ON gr.id = pr.grupo_id
        GROUP BY gr.id
    SQL
    formatted_results(sql)
  end

  def self.por_rubro
    sql = <<-SQL
      SELECT 
        ru.nombre AS nombre_rubro,
        #{base_columns_for_report}
        FROM presupuestos pre
        INNER JOIN rubros ru ON ru.id = pre.rubro_id
        GROUP BY ru.id
    SQL
    formatted_results(sql)
  end

  def self.por_anio
    sql = <<-SQL
      SELECT 
      extract(year from pr.fecha_inicio) as anio_inicio,
      #{base_columns_for_report}
      FROM presupuestos pre
      INNER JOIN proyectos pr ON pr.id = pre.proyecto_id
      GROUP BY 1
    SQL
    formatted_results(sql)
  end
  

  private

  def self.formatted_results(sql)
    ActiveRecord::Base.connection.exec_query(sql).to_a.map do |res|
      res['presupuesto_inicial'] = res['presupuesto_inicial'].to_f
      res['disponibilidad_total'] = res['disponibilidad_total'].to_f
      res['egreso_total'] = res['egreso_total'].to_f
      res['reserva_total'] = res['reserva_total'].to_f
      res
    end
  end

  def self.base_columns_for_report
    "SUM(pre.valor_inicial) AS presupuesto_inicial,
     SUM(pre.disponibilidad) AS disponibilidad_total,
     SUM(pre.egreso) AS egreso_total,
     SUM(pre.reserva) AS reserva_total"
  end
end
