namespace :scheduler do
  desc "Called by Heroku scheduler - Generate all tasks for current hour"
  task make_tasks: :environment do

    puts "-------------------------------"
    puts " make_tasks"
    tcount = make_recurring
    puts "#{tcount} recurring tasks created"
    tcount = make_nonrecurring
    puts "#{tcount} non-recurring tasks created"
    puts "-------------------------------"
  end

  desc "Undo all tasks for current DAY"
  task undo_make_tasks: :environment do
    count_deleted = 0

    @checklists = Checklist.for_today

    @checklists.each do |cl|
      tasks = cl.tasks.for_today
      tasks.each do |task|
        task.destroy!
        count_deleted += 1
      end

    end
    puts "-------------------------------"
    puts " undo_make_tasks"
    puts " #{count_deleted} tasks removed"
    puts "-------------------------------"
  end

  desc "Force make tasks for current hour"
  task remake_tasks: :environment do
    puts "-------------------------------"
    puts " remake_tasks"
    puts " ...method not defined yet"
    puts "-------------------------------"
  end

  def create_reminder_messages tasks
    tasks.each do |task|
      TaskMailer.task_reminder(task).deliver
    end
  end

  private

    def make_recurring
      tasks_created = 0

      # this will create all tasks for current day
      @checklists = Checklist.for_today
      todays_tasks = []

      @checklists.each do |cl|
        if cl.tasks.for_today.length == 0
          task = Task.new
          task.checklist_id = cl.id
          task.assigned_to_id = cl.assigned_to_id
          task.assigned_to_email = cl.assigned_to_email
          if task.assigned_to_id.nil?
            assignee = User.find_by(email: task.assigned_to_email)
            if !assignee.nil?
              task.assigned_to_id = assignee.id
            end
          end

          task.task_date = Date.today
          task.save!

          cl_items = cl.checklist_items

          cl_items.each do |cli|
            #TODO first check if exists already (for today)...
            task_item = TaskItem.new
            task_item.task_id = task.id
            task_item.checklist_id = cl.id
            task_item.checklist_item_id = cli.id
            task_item.completed = false
            task_item.save!
          end

          todays_tasks << task
        end
      end
      create_reminder_messages todays_tasks

      tasks_created = todays_tasks.length

    end

    def make_nonrecurring
      tasks_found = 0

      # this will create all tasks for current day
      @checklists = Checklist.non_recurring_for_today
      todays_tasks = []

      @checklists.each do |cl|

        if cl.tasks.length == 0
          task = Task.new
          task.checklist_id = cl.id
          task.assigned_to_id = cl.assigned_to_id
          task.assigned_to_email = cl.assigned_to_email
          task.task_date = Date.today
          task.save!

          cl_items = cl.checklist_items

          cl_items.each do |cli|
            task_item = TaskItem.new
            task_item.task_id = task.id
            task_item.checklist_id = cl.id
            task_item.checklist_item_id = cli.id
            task_item.completed = false
            task_item.save!
          end

        end
        if cl.tasks.uncompleted.length > 0
          todays_tasks << cl.tasks.uncompleted.first
        end

      end
      create_reminder_messages todays_tasks

      tasks_found = todays_tasks.length
    end

end
