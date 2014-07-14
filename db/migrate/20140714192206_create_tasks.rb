class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :checklist_id
      t.integer :assigned_to_id
      t.date :task_date
      t.string :assigned_to_email

      t.timestamps
    end
  end
end
