class TaskMailer < ActionMailer::Base
  default from: "admin@checkplease.cc"

  def task_reminder task
    email_to = task.assigned_to_email
    if email_to.nil?
      user = User.find(task.assigned_to_id)
      if !user.nil?
        email_to = user.email
      end
    end

    @task = task
    @task_url = Rails.env.development? ? "http://localhost:3000/tasks/#{@task.id}" : "http://www.checkplease.cc/tasks/#{@task.id}"
    mail to: email_to, subject: "Time to complete '#{task.checklist.name}'!"
  end

end
