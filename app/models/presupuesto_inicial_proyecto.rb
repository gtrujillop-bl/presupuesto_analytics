# == Schema Information
#
# Table name: presupuesto_inicial_proyectos
#
#  id            :bigint           not null, primary key
#  descripcion   :string           not null
#  valor_inicial :decimal(, )      not null
#  proyecto_id   :bigint           not null
#  rubro_id      :bigint           not null
#
# Indexes
#
#  fki_fk_presupuesto_inicial_proyectos                (proyecto_id)
#  index_presupuesto_inicial_proyectos_on_proyecto_id  (proyecto_id)
#  index_presupuesto_inicial_proyectos_on_rubro_id     (rubro_id)
#  uk_rubro_proyecto                                   (rubro_id,proyecto_id) UNIQUE
#
# Foreign Keys
#
#  fk_presupuesto_inicial_proyectos  (proyecto_id => proyectos.id)
#  fk_presupuestos_rubros            (rubro_id => rubros.id)
#
class PresupuestoInicialProyecto < ApplicationRecord
  require 'csv'
  belongs_to :rubro
  belongs_to :proyecto

  def self.csv_import_proyecto(file)
    PresupuestoInicialProyecto.transaction do
      presupuesto_inicial_proyectos = []
      begin
        CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          rubro = row[0]
          numero_proyecto = row[1]
          @rubro = Rubro.where(['lower(nombre) = ?', rubro.downcase]).first
          raise ActiveRecord::RecordNotFound.new("No se encontró rubro: #{rubro}") if @rubro.blank?

          @proyecto = Proyecto.find_by(numero_proyecto: numero_proyecto)
          raise  ActiveRecord::RecordNotFound.new("No se encontró proyecto: #{numero_proyecto}") if @proyecto.blank?

          @record = PresupuestoInicialProyecto.where(rubro_id: @rubro.id, proyecto_id: @proyecto.id)
          raise ActiveRecord::ActiveRecordError.new("Ya existe un presupuesto inicial con Rubro #{rubro} y Número de proyecto #{numero_proyecto}") if @record.present?
          
          element = row.to_h
          element = element.slice('descripcion', 'valor_inicial')
          element.merge!({'proyecto_id' => @proyecto.id, 'rubro_id' => @rubro.id})
          presupuesto_inicial_proyectos << element
        end
        PresupuestoInicialProyecto.create!(presupuesto_inicial_proyectos)
      rescue ActiveRecord::ActiveRecordError => e
        logger.error e.message
        # return false
        raise ActiveRecord::ActiveRecordError.new("No se pudo importar CSV #{e.message}")
      end
    end
  end

end
