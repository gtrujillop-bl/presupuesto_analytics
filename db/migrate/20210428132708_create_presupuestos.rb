class CreatePresupuestos < ActiveRecord::Migration[6.1]
  def change
    create_table :presupuestos do |t|
      t.references :rubro, null: false, foreign_key: true
      t.references :proyecto, null: false, foreign_key: true
      t.decimal :valor_inicial
      t.decimal :disponibilidad
      t.string :descripcion
      t.decimal :egreso
      t.decimal :reserva

      t.timestamps
    end
  end
end
