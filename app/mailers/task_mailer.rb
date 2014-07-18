class TaskMailer < ActionMailer::Base
  default from: "app27497064@heroku.com"

  def task_reminder task, user
    @user = user
    @task = task
    mail to: user.email, subject: "Complete this pending tasklist today!"
  end

end
