class CommentsController < ApplicationController
	before_action :authenticate_user!

	def index
		post = Post.includes(:user).find(params[:post_id])
		comments = post.comments.includes(:user).all

		render json: comments
	end


	def new
		post = Post.find(params[:post_id])
		@comment = post.comments.build
	end

	def create
		post = Post.find(params[:post_id])
		@comment = post.comments.build(comment_params)
		@comment.save!

		render json: @comment
	end


	private
	def comment_params
		params.require(:comment).permit(:content).merge(user_id: current_user.id, post_id: params[:post_id])
	end
end