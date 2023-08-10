class CreateConagros < ActiveRecord::Migration[5.1]
  def change
    create_table :conagros do |t|
      t.string :nombre
      t.string :apellidos
      t.string :correo
      t.string :pais
      t.string :institucion
      t.string :cargo
      t.string :eje

      t.timestamps
    end
  end
end
