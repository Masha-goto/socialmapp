class AccountsController < ApplicationController
  before_action :set_user, only: [:followings, :followers]

  def show
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to profile_path
    end

		to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day


		user_ids = @user.followings.pluck(:id)
		@posts = Post.where(user_id: user_ids, created_at: from...to).left_joins(:likes).group(:id).order('count(likes.id) DESC').limit(5)
  end

  def followings
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end