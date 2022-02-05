class CreateAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments do |t|
      t.integer :username
      t.references :project, null: false, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
      t.index [:username, :project_id], unique: true
    end
  end
end
