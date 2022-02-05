class CreateProjectAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :project_assignments do |t|
      t.string :user
      t.references :project, null: false, foreign_key: { on_delete: :cascade }
      t.boolean :active, default: true
      t.boolean :owner, default: false

      t.timestamps
      t.index [:user, :project_id], unique: true
    end
  end
end
