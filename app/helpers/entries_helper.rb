module EntriesHelper
	def owns_entry
		entry = Entry.find(params[:id])
		unless current_user == entry.robot.user || admin?(current_user)
			store_location
			flash[:error] = "You cannot modify this entry."
			redirect_to entries_path
		end
	end
end