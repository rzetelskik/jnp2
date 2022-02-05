class Project < ApplicationRecord
  has_many :project_assignments, dependent: :destroy
  has_many :statuses, dependent: :destroy
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
end
