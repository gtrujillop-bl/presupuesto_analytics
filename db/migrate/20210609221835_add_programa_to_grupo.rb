class AddProgramaToGrupo < ActiveRecord::Migration[6.1]
  def change
    add_reference :grupos, :programa, null: true, foreign_key: true, index: true
  end
end
