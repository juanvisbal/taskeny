class AddMissingColumnsToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :due_date, :date
    add_column :tasks, :priority, :integer, default: 1  # Default to medium priority (0=low, 1=medium, 2=high)
    
    # Add an index to improve query performance when filtering by due date
    add_index :tasks, :due_date
    # Add an index for priority to improve sorting
    add_index :tasks, :priority
  end
end