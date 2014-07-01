class CreateChecklistItems < ActiveRecord::Migration
  def change
    create_table :checklist_items do |t|
      t.string :check_name
      t.text :check_description
      t.integer :checklist_id

      t.timestamps
    end
  end
end
