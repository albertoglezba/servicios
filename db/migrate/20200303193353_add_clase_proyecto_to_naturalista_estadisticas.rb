class AddClaseProyectoToNaturalistaEstadisticas < ActiveRecord::Migration[5.1]
  def up
    change_table :naturalista_estadisticas do |t|
      t.string :clase_proyecto
    end
  end

  def down
    change_table :naturalista_estadisticas do |t|
      t.remove :clase_proyecto
    end
  end
end
