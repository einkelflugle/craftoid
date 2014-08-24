module SessionsHelper
	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.digest(remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
	    cookies.delete(:remember_token)
	    self.current_user = nil
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user?(user)
		current_user == user
	end

	def current_user
		remember_token = User.digest(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end

	def admin?(user)
		if current_user == user
			user.admin?
		end
	end

	# Filter out users who aren't signed in
	def signed_in_user
		unless signed_in?
			store_location
			flash[:notice] = "Please sign in."
			redirect_to signin_path
		end
	end

	# Confirm the user performing an action is an admin
	def admin_user
		redirect_to users_path unless current_user.admin?
	end

	# Make sure it's the right user trying to do something
	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user) || current_user.admin?
	end
end