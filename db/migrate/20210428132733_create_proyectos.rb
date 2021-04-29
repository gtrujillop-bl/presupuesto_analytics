class CreateProyectos < ActiveRecord::Migration[6.1]
  def change
    create_table :proyectos, if_not_exists: true do |t|
      t.string :nombre
      t.date :fecha_inicio
      t.date :fecha_fin
      t.references :facultad, null: false, foreign_key: true
      t.references :grupo, null: false, foreign_key: true
      t.references :semillero, null: false, foreign_key: true
      t.references :investigador, null: false, foreign_key: true
      t.string :numero_proyecto

      t.timestamps
    end
  end
end
