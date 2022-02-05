class Status < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :nullify
  validates :name, uniqueness: { scope: :project_id }, allow_nil: false, allow_blank: false
end
