class CreateEventos < ActiveRecord::Migration[5.1]
  def change
    create_table :eventos do |t|
      t.string :titulo
      t.string :actividad
      t.string :otra_actividad
      t.text :descripcion
      t.datetime :fecha_ini
      t.datetime :fecha_fin
      t.string :publico_meta
      t.string :formato
      t.string :estado
      t.string :informes
      t.boolean :celebracion
      t.string :usuario

      t.timestamps
    end
  end
end
