module EntriesHelper
	def owns_entry
		entry = Entry.find(params[:id])
		unless current_user == entry.robot.user || admin?(current_user)
			store_location
			flash[:error] = "You cannot modify this entry."
			redirect_to entries_path
		end
	end

	def competition_is_open
		competition = Competition.friendly.find(params[:competition_id])
		unless competition.open?
			store_location
			flash[:error] = "This competition has been closed, you cannot modify entries."
			redirect_to competition
		end
	end
end