class Task < ApplicationRecord
  validates :title, presence: true
  
  scope :pending, -> { where(completed: false) }
  scope :completed, -> { where(completed: true) }
  
  def toggle_completion!
    update(completed: !completed)
  end
end