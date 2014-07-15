class Task < ActiveRecord::Base

	has_many :task_items, :dependent => :destroy
	belongs_to :create_user, class_name: "User"
	belongs_to :checklist

	accepts_nested_attributes_for :task_items

	validates :checklist, presence: true



	#validates :create_user, presence: true

	#scope :for_sun, lambda { where(:recur_on=>'Sunday')}
	#scope :for_when, lambda {|query| where(["recur_on LIKE ?", "#{query.titlecase}"])}
	#scope :for_recur, lambda {|query| where(["recur_on LIKE ?", "%#{query}%"])}

	scope :for_today, lambda { where("created_at >= ? and created_at <= ?",
															Date.today.beginning_of_day, Date.today.end_of_day)}

end
