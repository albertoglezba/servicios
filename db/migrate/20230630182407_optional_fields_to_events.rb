class OptionalFieldsToEvents < ActiveRecord::Migration[5.1]
  def change
    change_table :eventos do |t|
      t.change :actividad, :string, null: true
      t.change :publico_meta, :string, null: true
      t.change :formato, :string, null: true
      t.change :estado, :string, null: true
      t.change :informes, :string, null: true
    end    
  end
end
