class AddProgramaToProyecto < ActiveRecord::Migration[6.1]
  def change
    add_reference :proyectos, :programa, null: true, foreign_key: true, index: true
  end
end
