class Checklist < ActiveRecord::Base

  has_many :checklist_items, :dependent => :destroy
  has_many :task_items, :dependent => :destroy
  has_many :tasks, :dependent => :destroy
  belongs_to :create_user, class_name: "User"

  validates :create_user, presence: true
  validates :name, presence: true

  #scope :for_sun, lambda { where(:recur_on=>'Sunday')}
  scope :for_when, lambda {|query| where(["recur_on LIKE ? OR recur_on ='Every Day'", "#{query.titlecase}"])}
  scope :for_monday, lambda {where("recur_on = 'Monday' OR recur_on ='Every Day' OR recur_on ='Weekdays'")}
  scope :for_tuesday, lambda {where("recur_on = 'Tuesday' OR recur_on ='Every Day' OR recur_on ='Weekdays'")}
  scope :for_wednesday, lambda {where("recur_on = 'Wednesday' OR recur_on ='Every Day' OR recur_on ='Weekdays'")}
  scope :for_thursday, lambda {where("recur_on = 'Thursday' OR recur_on ='Every Day' OR recur_on ='Weekdays'")}
  scope :for_friday, lambda {where("recur_on = 'Friday' OR recur_on ='Every Day' OR recur_on ='Weekdays'")}
  scope :for_saturday, lambda {where("recur_on = 'Saturday' OR recur_on ='Every Day' OR recur_on ='Weekends'")}
  scope :for_sunday, lambda {where("recur_on = 'Sunday' OR recur_on ='Every Day' OR recur_on ='Weekends'")}
  scope :for_user_id, lambda {|query| where(["create_user_id = ?", "#{query.to_i}"])}
  #scope :for_recur, lambda {|query| where(["recur_on LIKE ?", "%#{query}%"])}

  def self.for_today

    today = Date::DAYNAMES[Date.today.wday]

    if today == "Saturday" || today == "Sunday"
      recur_string = "(recur_on = 'Every Day' OR recur_on = 'Weekends' OR recur_on = ?) "
    else
      recur_string = "(recur_on = 'Every Day' OR recur_on = 'Weekdays' OR recur_on = ?) "
    end

    time_string = " AND (start_on <= ? AND (expires_on > ? OR expires_on IS NULL))"

    query_string = recur_string + time_string

    where query_string, today, Date.today, Date.today

  end

  #TODO - scope for checklists non-recurring (recur_on = nil)
  def self.non_recurring_for_today
    today = Date::DAYNAMES[Date.today.wday]

    time_string = " AND (start_on <= ? AND (expires_on > ? OR expires_on IS NULL))"

    query_string = "(recur_on IS NULL OR recur_on = '')" + time_string

    where query_string, Date.today, Date.today
  end

end
