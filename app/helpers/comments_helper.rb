module CommentsHelper
	def owns_comment(user, comment)
		comment.user_id = user.id
	end
end