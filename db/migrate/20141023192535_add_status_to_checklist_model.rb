class AddStatusToChecklistModel < ActiveRecord::Migration
  def change
    add_column :checklists, :status, :integer, :default => 0
  end
end
