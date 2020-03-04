class AddPublicToNaturalistaEstadisticas < ActiveRecord::Migration[5.1]
  def up
    change_table :naturalista_estadisticas do |t|
      t.boolean :publico, default: true, null: false
    end
  end

  def down
    change_table :naturalista_estadisticas do |t|
      t.remove :publico
    end
  end
end
