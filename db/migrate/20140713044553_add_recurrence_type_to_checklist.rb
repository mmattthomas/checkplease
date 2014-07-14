class AddRecurrenceTypeToChecklist < ActiveRecord::Migration
  def change
    add_column :checklists, :recur_on, :string
  end
end
