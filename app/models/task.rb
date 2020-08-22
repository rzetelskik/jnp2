class Task < ApplicationRecord
  belongs_to :project
  has_many :task_assignments, dependent: :destroy
  validates :project_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :created_by, presence: true
end
