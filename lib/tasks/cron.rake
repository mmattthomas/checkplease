namespace :cron do
  desc "A place to fix up existing checklist data"
  task fix_checklists: :environment do
    counter = 0
    checklists = Checklist.all
    checklists.each do |cl|
      if cl.assigned_to_email.nil? || cl.assigned_to_email.empty?
        if !cl.assigned_to_id.nil?
          u = User.find(cl.assigned_to_id)
          if !u.nil?
            cl.assigned_to_email = u.email
            counter +=1
          end
        end
      end
    end
    puts "Completed.  #{counter} checklists updated."
  end

  desc "Debug Data for Scheduler Jobs"
  task analyze_scheduler: :environment do
    c1 = Checklist.for_today.length
    c2 = Checklist.non_recurring_for_today.length
    c0 = Checklist.all.length

    t0 = Task.all.length
    t1 = Task.uncompleted.length
    t2 = Task.completed.length

    puts "Debug Analysis"
    puts "--------------"
    puts "#{c0} total checklists"
    puts "#{c1} recurring for today"
    puts "#{c2} non-recurring for today"
    puts "#{t0} total tasks"
    puts "#{t1} all uncompleted tasks"
    puts "#{t2} all completed tasks"
    puts "--------------"


  end

end
