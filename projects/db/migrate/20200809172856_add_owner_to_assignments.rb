class AddOwnerToAssignments < ActiveRecord::Migration[6.0]
  def change
    add_column :assignments, :owner, :boolean, default: false
  end
end
