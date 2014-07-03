class AddCreateUserToChecklist < ActiveRecord::Migration
  def change
    add_column :checklists, :create_user_id, :integer
  end
end
