class AddTipoInstitucionFieldToConagro < ActiveRecord::Migration[5.1]
  def change
    change_table :conagro do |t|
      t.string :tipo_institucion
    end
  end
end
