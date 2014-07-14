class AddAssigneeToChecklistModel < ActiveRecord::Migration
  def change
    add_column :checklists, :assigned_to_id, :integer
  end
end
