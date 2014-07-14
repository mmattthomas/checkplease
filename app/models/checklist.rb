class Checklist < ActiveRecord::Base

  has_many :checklist_items, :dependent => :destroy
  has_many :task_items, :dependent => :destroy
  belongs_to :create_user, class_name: "User"

  validates :create_user, presence: true
  validates :name, presence: true

  #scope :for_sun, lambda { where(:recur_on=>'Sunday')}
  scope :for_when, lambda {|query| where(["recur_on LIKE ?", "#{query.titlecase}"])}
  #scope :for_recur, lambda {|query| where(["recur_on LIKE ?", "%#{query}%"])}

end
