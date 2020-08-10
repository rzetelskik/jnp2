class AddOwnerToAssignments < ActiveRecord::Migration[6.0]
  def change
    add_column :assignments, :owner, :boolean
    add_index :assignments, [:project_id, :owner], unique: true
  end
end
