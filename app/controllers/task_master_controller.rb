class TaskMasterController < ApplicationController

  def index
  end

  # create all tasks for current day, and send notifications (unless already created)
  def make_all_for_today
    @message = "All tasks created for today."
    batch_task_build false
  end

  # create all tasks for current day, and send notifications
  def remake_all_for_today
    @message = "All tasks created for today."
    batch_task_build true
    render 'make_all_for_today'
  end

  # delete all tasks created today (undo measure)
  def undo_all_for_today
    batch_task_remove
    @myvar = "hello cruel world!  Today is #{Date.today}"
  end

  private

    def batch_task_build resend
      @updatecount = 0
      @tasks_created = 0

      if current_user.email != "citytank@gmail.com"
        @message = "Must be admin user to perform this task"
        return
      end

      # this will create all tasks for current day
      @checklists = Checklist.for_today

      puts "***>>>  count of checklists is #{@checklists.length}"

      dbg_counter = 0

      @todays_tasks = []

      @checklists.each do |cl|
        @updatecount = @updatecount + 1
        if cl.tasks.for_today.length == 0
          task = Task.new
          task.checklist_id = cl.id
          task.assigned_to_id = cl.assigned_to_id
          task.assigned_to_email = cl.assigned_to_email
          task.task_date = Date.today
          task.save!

          #dbg_taskitem_counter = 0
          #puts "Task # #{dbg_counter}"
          #puts task.checklist.name

          cl_items = cl.checklist_items

          cl_items.each do |cli|
            #TODO first check if exists already (for today)...
            task_item = TaskItem.new
            task_item.task_id = task.id
            task_item.checklist_id = cl.id
            task_item.checklist_item_id = cli.id
            task_item.completed = false
            task_item.save!

            #puts "TaskItem # #{dbg_taskitem_counter}"
            #dbg_taskitem_counter += 1
          end

          @todays_tasks << task
          @tasks_created = @tasks_created + 1

        else
            puts "------------------------------------"
            puts "#{cl.name} already has tasks created"
            puts "------------------------------------"
        end #end if


      end

      create_reminder_messages @todays_tasks

    end

    #delete task_items created today
    def batch_task_remove
      @count_deleted = 0
      today = Date::DAYNAMES[Date.today.wday]
      @checklists = Checklist.for_today

      @checklists.each do |cl|
        tasks = cl.tasks.for_today
        tasks.each do |task|
          task.destroy!
          @count_deleted += 1
        end

      end
    end

    def create_reminder_messages tasks

      tasks.each do |t|
        #TODO - this should be ASSIGNED TO not current user!
        TaskMailer.task_reminder(t).deliver
      end

    end

end
