class DropAssignments < ActiveRecord::Migration[6.0]
  def change
    drop_table :assignments
  end
end
