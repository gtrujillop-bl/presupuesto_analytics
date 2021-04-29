class CreatePresupuestoInicialProyectos < ActiveRecord::Migration[6.1]
  def change
    create_table :presupuesto_inicial_proyectos, if_not_exists: true do |t|
      t.references :rubro, null: false, foreign_key: true
      t.references :proyecto, null: false, foreign_key: true
      t.string :descripcion
      t.decimal :valor_inicial

      t.timestamps
    end
  end
end
