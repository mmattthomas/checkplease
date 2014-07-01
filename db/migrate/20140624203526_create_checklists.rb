class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.string :name
      t.text :description
      t.date :expires_on

      t.timestamps
    end
  end
end
