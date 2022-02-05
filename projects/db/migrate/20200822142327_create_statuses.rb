class CreateStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :statuses do |t|
      t.string :name, null: false
      t.references :project, null: false, foreign_key: { on_delete: :cascade }
      t.index [:project_id, :name], unique: true
    end
  end
end
