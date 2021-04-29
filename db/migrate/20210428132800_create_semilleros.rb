class CreateSemilleros < ActiveRecord::Migration[6.1]
  def change
    create_table :semilleros, if_not_exists: true do |t|
      t.string :nombre
      t.references :grupo, null: false, foreign_key: true
      t.string :descripcion

      t.timestamps
    end
  end
end
