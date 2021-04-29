class CreateInvestigadores < ActiveRecord::Migration[6.1]
  def change
    create_table :investigadores, if_not_exists: true do |t|
      t.integer :cedula
      t.string :nombres
      t.string :apellidos

      t.timestamps
    end
  end
end
