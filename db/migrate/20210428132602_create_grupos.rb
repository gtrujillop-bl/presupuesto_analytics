class CreateGrupos < ActiveRecord::Migration[6.1]
  def change
    create_table :grupos do |t|
      t.string :nombre
      t.references :facultad, null: false, foreign_key: true

      t.timestamps
    end
  end
end
