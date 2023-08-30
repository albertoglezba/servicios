# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20230830191855) do

  create_table "conagro", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci" do |t|
    t.string "nombre"
    t.string "apellidos"
    t.string "correo"
    t.string "pais"
    t.string "institucion"
    t.string "cargo"
    t.string "eje"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tipo_institucion"
  end

  create_table "eventos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci" do |t|
    t.string "titulo", null: false
    t.string "actividad"
    t.string "otra_actividad"
    t.text "descripcion", null: false
    t.datetime "fecha_ini", null: false
    t.datetime "fecha_fin", null: false
    t.string "publico_meta"
    t.string "formato"
    t.string "estado"
    t.text "informes"
    t.boolean "celebracion", default: false, null: false
    t.string "usuario", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "naturalista_estadisticas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci" do |t|
    t.string "titulo", limit: 190
    t.string "icono"
    t.text "descripcion"
    t.integer "lugar_id"
    t.integer "numero_especies"
    t.integer "numero_observaciones"
    t.integer "numero_observadores"
    t.integer "numero_identificadores"
    t.integer "numero_miembros"
    t.string "estado"
    t.string "tipo_proyecto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ubicacion", limit: 190
    t.string "clase_proyecto"
    t.boolean "publico", default: true, null: false
    t.boolean "actualizo", default: true, null: false
    t.index ["titulo"], name: "index_naturalista_estadisticas_on_titulo"
    t.index ["ubicacion"], name: "index_naturalista_estadisticas_on_ubicacion"
  end

end
