class AddCreateUserIdToChecklist < ActiveRecord::Migration
  def change
    add_column :checklist_items, :create_user_id, :integer
  end
end
