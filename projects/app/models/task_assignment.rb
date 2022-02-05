class TaskAssignment < ApplicationRecord
  belongs_to :task
  validates :user, presence: true, uniqueness: { scope: :task_id }
  validates :task_id, presence: true
end
