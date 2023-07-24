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

ActiveRecord::Schema.define(version: 20230630182407) do

  create_table "eventos", force: :cascade do |t|
    t.string "titulo", null: false
    t.string "actividad"
    t.string "otra_actividad"
    t.text "descripcion", null: false
    t.datetime "fecha_ini", null: false
    t.datetime "fecha_fin", null: false
    t.string "publico_meta"
    t.string "formato"
    t.string "estado"
    t.string "informes"
    t.boolean "celebracion", default: false, null: false
    t.string "usuario", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "naturalista_estadisticas", force: :cascade do |t|
    t.string "titulo"
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
    t.string "ubicacion"
    t.string "clase_proyecto"
    t.boolean "publico", default: true, null: false
    t.boolean "actualizo", default: true, null: false
    t.index ["titulo"], name: "index_naturalista_estadisticas_on_titulo"
    t.index ["ubicacion"], name: "index_naturalista_estadisticas_on_ubicacion"
  end

end
