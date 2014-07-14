class TaskMasterController < ApplicationController

  def index
  end

  def make_all_for_today

    # this will create all tasks for current day
    today = Date::DAYNAMES[Date.today.wday]
    @checklists = Checklist.for_when today

    @checklists.each do |cl|
      cl_items = cl.checklist_items

      cl_items.each do |cli|
        #TODO first check if exists already (for today)...
        task_item = TaskItem.new
        task_item.checklist_id = cl.id
        task_item.checklist_item_id = cli.id
        task_item.completed = false
        task_item.save!
      end

    end

  end

  #delete task_items created today
  def undo_all_for_today
    @count_deleted = 0
    today = Date::DAYNAMES[Date.today.wday]
    @checklists = Checklist.for_when today

    @checklists.each do |cl|
      task_items = cl.task_items

      task_items.each do |task_item|
        task_item.destroy!
        @count_deleted += 1
      end

    end
  end

end
