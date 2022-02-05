class ProjectAssignment < ApplicationRecord
  belongs_to :project
  validates :owner, uniqueness: { scope: :project_id }, if: -> { owner == true}
  validate :active_changed, on: :update

  def activate
    self.update(active: true)
  end

  def deactivate
    self.update(active: false)
  end

  def active_changed
    errors.add(:base, 'User has already been assigned/unassigned') unless active_changed?
  end
end
