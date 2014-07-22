class AddTimingAndAssigneeFieldsToChecklist < ActiveRecord::Migration
  def change
    add_column :checklists, :start_on, :date
    add_column :checklists, :notify_hour, :integer       #24hr time to create task & notify
    add_column :checklists, :assigned_to_email, :string
  end
end
