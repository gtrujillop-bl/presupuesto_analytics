class CreateFacultades < ActiveRecord::Migration[6.1]
  def change
    create_table :facultades, if_not_exists: true do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
