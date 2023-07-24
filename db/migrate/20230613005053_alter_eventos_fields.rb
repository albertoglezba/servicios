class AlterEventosFields < ActiveRecord::Migration[5.1]
  def change
    change_table :eventos do |t|
      t.change :titulo, :string, null: false
      t.change :actividad, :string, null: false
      t.change :descripcion, :text, null: false
      t.change :fecha_ini, :datetime, null: false
      t.change :fecha_fin, :datetime, null: false
      t.change :publico_meta, :string, null: false
      t.change :formato, :string, null: false
      t.change :estado, :string, null: false
      t.change :informes, :string, null: false
      t.change :celebracion, :boolean, default: false, null: false
      t.change :usuario, :string, null: false
    end    
  end
end
