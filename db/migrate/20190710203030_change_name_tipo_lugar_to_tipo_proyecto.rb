class ChangeNameTipoLugarToTipoProyecto < ActiveRecord::Migration[5.1]
  def up
    change_table :naturalista_estadisticas do |t|
      t.rename :tipo_lugar, :tipo_proyecto
    end
  end

  def down
    change_table :naturalista_estadisticas do |t|
      t.rename :tipo_proyecto, :tipo_lugar
    end
  end
end
