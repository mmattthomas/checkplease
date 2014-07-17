class TaskMailer < ActionMailer::Base
  default from: "admin@checkplease.cc"

  def task_reminder task, user
    @user = user
    @task = task
    mail to: user.email, subject: "Complete this pending tasklist today!"
  end

end
