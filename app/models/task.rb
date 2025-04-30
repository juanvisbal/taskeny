class Task < ApplicationRecord
  validates :title, presence: true
  validates :due_date, presence: true, allow_blank: true
  
  # Define the possible priorities
  enum :priority, low: 0, medium: 1, high: 2, default: :medium
  
  scope :pending, -> { where(completed: false) }
  scope :completed, -> { where(completed: true) }
  scope :overdue, -> { where("due_date < ? AND completed = ?", Date.today, false) }
  scope :high_priority, -> { where(priority: :high) }
  
  # Add associations for future implementation
  # belongs_to :project, optional: true
  # belongs_to :category, optional: true
  # has_many :task_tags, dependent: :destroy
  # has_many :tags, through: :task_tags
  # has_many :comments, dependent: :destroy
  
  def toggle_completion!
    update(completed: !completed)
  end
  
  def status
    completed? ? "completed" : "pending"
  end
  
  def overdue?
    due_date.present? && due_date < Date.today && !completed
  end
end
