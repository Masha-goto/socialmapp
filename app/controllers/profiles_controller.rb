class ProfilesController < ApplicationController
	before_action :authenticate_user!

	def show
		@profile = current_user.profile
	end

	def edit
		@profile = current_user.prepare_profile
	end

	def update
		@profile = current_user.prepare_profile
		@profile.assign_attributes(profile_params)
		if @profile.save
			redirect_to profile_path, notice: 'プロフィール作成できました!'
		else
			flash.now[:error] = '作成できませんでした'
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