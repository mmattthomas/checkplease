class TaskItem < ActiveRecord::Base

	belongs_to :checklist
	belongs_to :checklist_item
	belongs_to :task

	validates :checklist_id, presence: true
	validates :checklist_item_id, presence: true

#TODO - some "scopes"... easy way to get all task items for list for a certain day
#TODO - CREATE tasks based on checklists...somehow...might need to be controller

	scope :for_today, lambda { where("created_at >= ? and created_at <= ?",
															Date.today.beginning_of_day, Date.today.end_of_day)}

	scope :incomplete, lambda { where("task_items.completed = false") }
	scope :complete, lambda { where("task_items.completed = true") }

	scope :sorted, lambda { order("task_items.created_at ASC") }
	#note, time zones applicable?  create fields should be all on server, right?

	def get_a_num
		DateTime.now.strftime "%S"
	end

	def get_display_val
		if completed = true
			"[X]"
		else
			"[ ]"
		end
	end

end
