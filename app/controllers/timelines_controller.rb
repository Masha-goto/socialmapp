class TimelinesController < ApplicationController
	before_action :authenticate_user!

	def show
		to = Time.current.at_end_of_day
    from = (to - 1.day).at_beginning_of_day

		user_ids = current_user.followings.pluck(:id)
		@posts = Post.where(user_id: user_ids, created_at: from...to).left_joins(:likes).group(:id).order('count(likes.id) DESC').limit(5)
	end
end