class AddStatusToTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :status, null: true, default: nil, foreign_key: { on_delete: :nullify}
  end
end
