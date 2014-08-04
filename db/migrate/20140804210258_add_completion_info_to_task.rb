class AddCompletionInfoToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :percent_complete, :integer
    add_column :tasks, :complete, :boolean
  end
end
