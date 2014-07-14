class CreateTaskItems < ActiveRecord::Migration
  def change
    create_table :task_items do |t|
      t.integer :checklist_item_id
      t.integer :checklist_id
      t.boolean :completed
      t.text :notes
      t.integer :completed_by_user_id

      t.timestamps
    end
  end
end
