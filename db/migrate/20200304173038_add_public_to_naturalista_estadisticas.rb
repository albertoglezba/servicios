class AddPublicToNaturalistaEstadisticas < ActiveRecord::Migration[5.1]
  def up
    change_table :naturalista_estadisticas do |t|
      t.string :public
    end
  end

  def down
    change_table :naturalista_estadisticas do |t|
      t.remove :public
    end
  end
end
