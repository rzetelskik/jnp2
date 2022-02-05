class CreateTaskAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :task_assignments do |t|
      t.string :user
      t.references :task, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
      t.index [:user, :task_id], unique: true
    end
  end
end
