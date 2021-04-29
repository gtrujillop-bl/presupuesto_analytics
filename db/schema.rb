# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_28_132800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "facultades", force: :cascade do |t|
    t.string "nombre"
    t.index ["nombre"], name: "uk_nombre_facultad", unique: true
  end

  create_table "grupos", force: :cascade do |t|
    t.string "nombre"
    t.bigint "facultad_id", comment: "Identificador de la facultad"
    t.index ["facultad_id"], name: "fki_fk_grupos_facultades"
    t.index ["facultad_id"], name: "index_grupos_on_facultad_id"
  end

  create_table "investigadores", force: :cascade do |t|
    t.integer "cedula"
    t.string "nombres"
    t.string "apellidos"
    t.index ["cedula"], name: "uk_cedula_investigador", unique: true
    t.index ["nombres", "apellidos"], name: "uk_nombres_apellidos_investigador", unique: true
  end

  create_table "presupuesto_inicial_proyectos", force: :cascade do |t|
    t.bigint "rubro_id", null: false
    t.bigint "proyecto_id", null: false
    t.string "descripcion", null: false
    t.decimal "valor_inicial", null: false
    t.index ["proyecto_id"], name: "fki_fk_presupuesto_inicial_proyectos"
    t.index ["proyecto_id"], name: "index_presupuesto_inicial_proyectos_on_proyecto_id"
    t.index ["rubro_id", "proyecto_id"], name: "uk_rubro_proyecto", unique: true
    t.index ["rubro_id"], name: "index_presupuesto_inicial_proyectos_on_rubro_id"
  end

  create_table "presupuestos", force: :cascade do |t|
    t.bigint "rubro_id"
    t.bigint "proyecto_id"
    t.decimal "valor_inicial"
    t.decimal "disponibilidad", default: "0.0"
    t.string "descripcion"
    t.decimal "egreso", default: "0.0"
    t.decimal "reserva", default: "0.0"
    t.index ["proyecto_id"], name: "fki_fk_presupuestos_proyectos"
    t.index ["proyecto_id"], name: "index_presupuestos_on_proyecto_id"
    t.index ["rubro_id"], name: "fki_fk_presupuestos_rubros"
    t.index ["rubro_id"], name: "index_presupuestos_on_rubro_id"
  end

  create_table "proyectos", force: :cascade do |t|
    t.string "nombre"
    t.date "fecha_inicio"
    t.date "fecha_fin", null: false
    t.bigint "facultad_id"
    t.bigint "grupo_id"
    t.bigint "semillero_id"
    t.bigint "investigador_id"
    t.string "numero_proyecto", null: false
    t.index ["facultad_id"], name: "fki_fk_proyectos_facultades"
    t.index ["facultad_id"], name: "index_proyectos_on_facultad_id"
    t.index ["grupo_id"], name: "fki_fk_proyectos_grupos"
    t.index ["grupo_id"], name: "index_proyectos_on_grupo_id"
    t.index ["investigador_id"], name: "fki_fk_proyectos_investigadores"
    t.index ["investigador_id"], name: "index_proyectos_on_investigador_id"
    t.index ["semillero_id"], name: "fki_fk_proyectos_semilleros"
    t.index ["semillero_id"], name: "index_proyectos_on_semillero_id"
  end

  create_table "rubros", force: :cascade do |t|
    t.string "nombre", null: false
    t.string "descripcion", limit: 255
    t.index ["nombre"], name: "uk_nombre_rubro", unique: true
  end

  create_table "semilleros", force: :cascade do |t|
    t.string "nombre"
    t.bigint "grupo_id"
    t.string "descripcion", limit: 255
    t.index ["grupo_id"], name: "fki_fk_semilleros_grupos"
    t.index ["grupo_id"], name: "index_semilleros_on_grupo_id"
  end

  add_foreign_key "grupos", "facultades", column: "facultad_id", name: "fk_grupos_facultades", on_update: :cascade, on_delete: :cascade
  add_foreign_key "presupuesto_inicial_proyectos", "proyectos", name: "fk_presupuesto_inicial_proyectos"
  add_foreign_key "presupuesto_inicial_proyectos", "rubros", name: "fk_presupuestos_rubros"
  add_foreign_key "presupuestos", "proyectos", name: "fk_presupuestos_proyectos"
  add_foreign_key "presupuestos", "rubros", name: "fk_presupuestos_rubros"
  add_foreign_key "proyectos", "facultades", column: "facultad_id", name: "fk_proyectos_facultades"
  add_foreign_key "proyectos", "grupos", name: "fk_proyectos_grupos"
  add_foreign_key "proyectos", "investigadores", column: "investigador_id", name: "fk_proyectos_investigadores"
  add_foreign_key "proyectos", "semilleros", name: "fk_proyectos_semilleros"
  add_foreign_key "semilleros", "grupos", name: "fk_semilleros_grupos"
end
