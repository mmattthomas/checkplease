class Task < ActiveRecord::Base

	has_many :task_items, :dependent => :destroy
	belongs_to :create_user, class_name: "User"
	belongs_to :checklist

	accepts_nested_attributes_for :task_items
	#per dickeyxxx, this is buggy and not great.

	validates :checklist, presence: true

	#validates :create_user, presence: true

	#scope :for_sun, lambda { where(:recur_on=>'Sunday')}
	#scope :for_when, lambda {|query| where(["recur_on LIKE ?", "#{query.titlecase}"])}
	#scope :for_recur, lambda {|query| where(["recur_on LIKE ?", "%#{query}%"])}
	scope :sorted, lambda { order("tasks.task_date ASC")}
	scope :for_today, lambda { where("created_at >= ? and created_at <= ?",
															Date.today.beginning_of_day, Date.today.end_of_day)}

	scope :for_assigned_to_email, lambda {|query| where(["tasks.assigned_to_email = ?", "#{query}"])}
	scope :uncompleted, lambda { where("tasks.id in (select task_id from task_items where completed = false)") }
	scope :completed, lambda { where("tasks.id in (select task_id from task_items where completed = true)") }

	scope :my_uncompleted, lambda {|query| where(["(tasks.id in (select task_id from task_items where completed = false)) and assigned_to_id = ?", query])}

	scope :my_recentcompleted, lambda {|query| where(["tasks.percent_complete = 100 and task_date >= current_date - interval '7 days'  and assigned_to_id = ?", query])}

	def get_percent_complete
		if self.task_items.incomplete.length == 0
			100
		else
			pc = (self.task_items.length - self.task_items.incomplete.length) / self.task_items.length.to_f * 100
			pc.to_i
		end

	end

end
