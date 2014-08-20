class Checklist < ActiveRecord::Base

  has_many :checklist_items, :dependent => :destroy
  has_many :task_items, :dependent => :destroy
  has_many :tasks, :dependent => :destroy
  belongs_to :create_user, class_name: "User"

  validates :create_user, presence: true
  validates :name, presence: true

  #scope :for_sun, lambda { where(:recur_on=>'Sunday')}
  scope :for_when, lambda {|query| where(["recur_on LIKE ? OR recur_on ='Day'", "#{query.titlecase}"])}
  scope :for_user_id, lambda {|query| where(["create_user_id = ?", "#{query.to_i}"])}
  scope :for_assigned_to_email, lambda {|query| where(["checklists.assigned_to_email = ?", "#{query}"])}
  #scope :for_recur, lambda {|query| where(["recur_on LIKE ?", "%#{query}%"])}

  def self.for_today

    today = Date::DAYNAMES[Date.today.wday]

    if today == "Saturday" || today == "Sunday"
      recur_string = "(recur_on = 'Day' OR recur_on = 'Weekends' OR recur_on = ?) "
    else
      recur_string = "(recur_on = 'Day' OR recur_on = 'Weekday' OR recur_on = ?) "
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

  def get_most_recent_incomplete_task_for_user user_id
    self.tasks.my_uncompleted(user_id).sorted.first
  end

  # Some special codes here!
  # -1 : Checklist currently not active
  # -2 : No task exists ... link to create one!
  def get_dashboard user_id
    task = self.tasks.my_uncompleted(user_id).sorted.first
    if task.nil?
      if self.start_on > Date.today || self.expires_on < Date.today
        puts "went here negative one"
        -1
      else
        -2                            # -2 : no task currently - create one!
      end
    else
      task.percent_complete
    end
  end

end
