class CreateRubros < ActiveRecord::Migration[6.1]
  def change
    create_table :rubros, if_not_exists: true do |t|
      t.string :nombre
      t.string :descripcion

      t.timestamps
    end
  end
end
