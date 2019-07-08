class AddUbicacionToNaturalistaEstadisticas < ActiveRecord::Migration[5.1]
  def up
    change_table :naturalista_estadisticas do |t|
      t.string :ubicacion
      t.index :ubicacion
      t.index :titulo
    end
  end

  def down
    change_table :naturalista_estadisticas do |t|
      t.remove :ubicacion
    end
  end
end
