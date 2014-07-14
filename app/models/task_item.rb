class TaskItem < ActiveRecord::Base

	belongs_to :checklist

	validates :checklist_id, presence: true
	validates :checklist_item_id, presence: true

#TODO - some "scopes"... easy way to get all task items for list for a certain day
#TODO - CREATE tasks based on checklists...somehow...might need to be controller

end
