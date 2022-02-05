class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: { on_delete: :cascade }
      t.string :name
      t.string :description
      t.string :created_by

      t.timestamps
    end
  end
end
