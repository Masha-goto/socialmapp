class CommentsController < ApplicationController
	before_action :set_post, only: [:show]
	before_action :authenticate_user!

	def show
		@post =Post.includes(:user).find(params[:id])
		@comments = @post.comments.includes(:user).all
		@comment = @post.comments.build(user_id: current_user.id) if current_user
	end

	def new
		post = Post.find(params[:post_id])
		@comment = post.comments.build
	end

	def create
		post = Post.find(params[:post_id])
		@comment = post.comments.build(comment_params)
		if @comment.save
			redirect_to post_comment_path(post, post.id), notice: 'コメントを追加しました'
		else
			flash.now[:error] = 'コメントできませんでした'
			render :new
		end
	end


	private
	def comment_params
		params.require(:comment).permit(:content).merge(user_id: current_user.id, post_id: params[:post_id])
	end

	def set_post
		@post = Post.find(params[:id])
		# @comment = Comment.find(params[:id])
	end
end