class ProfilesController < ApplicationController
	before_action :authenticate_user!

	def show
		@profile = current_user.profile

		to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day

		user_ids = current_user.followings.pluck(:id)
		@posts = Post.where(user_id: user_ids, created_at: from...to).left_joins(:likes).group(:id).order('count(likes.id) DESC').limit(5)
	end

	def edit
		@profile = current_user.prepare_profile
	end

	def update
		@profile = current_user.prepare_profile
		@profile.assign_attributes(profile_params)
		if @profile.save
			redirect_to profile_path, notice: 'プロフィール更新できました!'
		else
			flash.now[:error] = '更新できませんでした'
			render :edit
		end
	end

	private
	def profile_params
		params.require(:profile).permit(
			:account,
			:avatar
		)
	end
end