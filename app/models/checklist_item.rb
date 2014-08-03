class ChecklistItem < ActiveRecord::Base

  belongs_to :checklist
  has_many :task_items

  scope :sorted, lambda { order("checklist_items.created_at ASC")}
end
