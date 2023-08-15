class TransformInfoIntoText < ActiveRecord::Migration[5.1]
  def change
    change_table :eventos do |t|
      t.change :informes, :text, null: true
    end
  end
end
