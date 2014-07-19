class TaskMailer < ActionMailer::Base
  default from: "admin@checkplease.cc"

  def task_reminder task, user
    @user = User.find(task.assigned_to_id)
    @task = task
    mail to: @user.email, subject: "Time to complete '#{task.checklist.name}'!"
  end

end
