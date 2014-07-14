class AddTaskModelRelationships < ActiveRecord::Migration
  def change
    add_column :task_items, :task_id, :integer
  end
end
