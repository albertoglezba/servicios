class CreateNaturalistaEstadisticas < ActiveRecord::Migration[5.1]
  def change
    Naturalista::Estadistica.connection.enable_extension "sqlite"

    Naturalista::Estadistica.connection.create_table :naturalista_estadisticas do |t|
      t.string :titulo, :limit => 190
      t.string :icono
      t.text :descripcion
      t.integer :lugar_id
      t.integer :numero_especies
      t.integer :numero_observaciones
      t.integer :numero_observadores
      t.integer :numero_identificadores
      t.integer :numero_miembros
      t.string :estado
      t.string :tipo_lugar

      t.timestamps
    end
  end
end
