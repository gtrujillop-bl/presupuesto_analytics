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
        cast(SUM(pre.valor_inicial) AS money) AS presupuesto_inicial,
        cast(SUM(pre.disponibilidad) AS money) AS disponibilidad_total,
        cast(SUM(pre.egreso) AS money) AS egreso_total,
        cast(SUM(pre.reserva) AS money) AS reserva_total
        FROM presupuestos pre
        INNER JOIN proyectos pr ON pr.id = pre.proyecto_id
        INNER JOIN facultades fa ON pr.facultad_id = fa.id
        GROUP BY pr.id, fa.id;
    SQL
    ActiveRecord::Base.connection.execute(sql)
  end
end
