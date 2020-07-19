class AddNumeroActualizoToEstadisticas < ActiveRecord::Migration[5.1]
  def up
    change_table :naturalista_estadisticas do |t|
      t.boolean :actualizo, default: true, null: false
    end
  end

  def down
    change_table :naturalista_estadisticas do |t|
      t.remove :actualizo
    end
  end
end
