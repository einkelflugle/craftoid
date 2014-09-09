module CompetitionsHelper
	def owns_competition
		@competition = Competition.find(params[:id])
		unless current_user == @competition.user || admin?(current_user)
			store_location
			flash[:error] = "You cannot modify this competition."
			redirect_to competitions_path
		end
	end
end