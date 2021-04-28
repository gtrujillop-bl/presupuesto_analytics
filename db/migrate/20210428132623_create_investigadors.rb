class CreateInvestigadors < ActiveRecord::Migration[6.1]
  def change
    create_table :investigadors do |t|
      t.integer :cedula
      t.string :nombres
      t.string :apellidos

      t.timestamps
    end
  end
end
