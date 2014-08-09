# app/controllers/registrations_controller.rb
class MoreDevise::RegistrationsController < Devise::RegistrationsController
	def new
		super
	end

	def create
		super
		if resource.save
			#resource is USER
			#we created a new user here.. we want to update any tasks or checklists assigned to this user's email
			#address, to be the new email address
			email_addy = resource.email

			checklists = Checklist.for_assigned_to_email email_addy
			checklists.each do |cl|
				cl.update assigned_to_id: resource.id
			end

			tasks = Task.for_assigned_to_email email_addy
			tasks.each do |task|
				task.update assigned_to_id: resource.id
			end
		end
	end

	def update
		super
	end

	def destroy
		super
	end
end
