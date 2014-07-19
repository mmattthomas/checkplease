class TaskMailer < ActionMailer::Base
  default from: "admin@checkplease.cc"

  def task_reminder task
    @user = User.find(task.assigned_to_id)
    @task = task
    @task_url = Rails.env.development? ? "http://localhost:3000/tasks/#{@task.id}" : "http://www.checkplease.cc/tasks/#{@task.id}"
    mail to: @user.email, subject: "Time to complete '#{task.checklist.name}'!"
  end

end
