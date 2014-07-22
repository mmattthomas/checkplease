namespace :cron do
  desc "A place to fix up existing checklist data"
  task fix_checklists: :environment do
    counter = 0
    checklists = Checklist.all
    checklists.each do |cl|
      if cl.assigned_to_email.empty?
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

end
