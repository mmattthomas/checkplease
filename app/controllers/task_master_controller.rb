class TaskMasterController < ApplicationController

  def index
  end

  def make_all_for_today

    if current_user.email != "citytank@gmail.com"
      return
    end
    # this will create all tasks for current day
    today = Date::DAYNAMES[Date.today.wday]
    @checklists = Checklist.for_when today

    dbg_counter = 0

    @todays_tasks = []

    @checklists.each do |cl|
      task = Task.new
      task.checklist_id = cl.id
      task.assigned_to_id = cl.assigned_to_id
      task.task_date = Date.today
      task.save!

      @todays_tasks << task

      dbg_taskitem_counter = 0
      puts "Task # #{dbg_counter}"
      puts task.checklist.name

      cl_items = cl.checklist_items

      cl_items.each do |cli|
        #TODO first check if exists already (for today)...
        task_item = TaskItem.new
        task_item.task_id = task.id
        task_item.checklist_id = cl.id
        task_item.checklist_item_id = cli.id
        task_item.completed = false
        task_item.save!

        puts "TaskItem # #{dbg_taskitem_counter}"
        dbg_taskitem_counter += 1

      end

      puts "--------"
      create_reminder_messages @todays_tasks

      dbg_counter += 1
    end

  end

  #delete task_items created today
  def undo_all_for_today
    @count_deleted = 0
    today = Date::DAYNAMES[Date.today.wday]
    @checklists = Checklist.for_when today

    @checklists.each do |cl|
      tasks = cl.tasks.for_today
      tasks.each do |task|
        task.destroy!
        @count_deleted += 1
      end

    end
  end

  private

  def create_reminder_messages tasks

    tasks.each do |t|
      TaskMailer.task_reminder(t, current_user).deliver
    end

  end

end
