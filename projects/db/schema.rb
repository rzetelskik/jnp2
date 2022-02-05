# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_22_143901) do

  create_table "project_assignments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "user"
    t.bigint "project_id", null: false
    t.boolean "active", default: true
    t.boolean "owner", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_assignments_on_project_id"
    t.index ["user", "project_id"], name: "index_project_assignments_on_user_and_project_id", unique: true
  end

  create_table "projects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "project_id", null: false
    t.index ["project_id", "name"], name: "index_statuses_on_project_id_and_name", unique: true
    t.index ["project_id"], name: "index_statuses_on_project_id"
  end

  create_table "task_assignments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "user"
    t.bigint "task_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_task_assignments_on_task_id"
    t.index ["user", "task_id"], name: "index_task_assignments_on_user_and_task_id", unique: true
  end

  create_table "tasks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "name"
    t.string "description"
    t.string "created_by"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "status_id"
    t.index ["project_id"], name: "index_tasks_on_project_id"
    t.index ["status_id"], name: "index_tasks_on_status_id"
  end

  add_foreign_key "project_assignments", "projects", on_delete: :cascade
  add_foreign_key "statuses", "projects", on_delete: :cascade
  add_foreign_key "task_assignments", "tasks", on_delete: :cascade
  add_foreign_key "tasks", "projects", on_delete: :cascade
  add_foreign_key "tasks", "statuses", on_delete: :nullify
end
