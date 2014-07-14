class ChecklistItem < ActiveRecord::Base

  belongs_to :checklist
  has_many :task_items

end
