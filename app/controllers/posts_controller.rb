class PostsController < ApplicationController
	before_action :set_post, only: [:show]
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def index
		@posts = Post.all
	end

	def show
		@post =Post.includes(:user).find(params[:id])
		@comments = @post.comments.includes(:user).all
		@comment = @post.comments.build(user_id: current_user.id) if current_user
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			redirect_to post_path(@post), notice: '保存できました'
		else
			flash.now[:error] = '保存に失敗しました'
			render :new
		end
	end

	def edit
		@post = current_user.posts.find(params[:id])
	end

	def update
		@post = current_user.posts.find(params[:id])
		if @post.update(post_params)
			redirect_to post_path(@post), notice: '更新できました'
		else
			flash.now[:error] = '更新できませんでした'
			render :edit
		end
	end

	def destroy
		post = current_user.posts.find(params[:id])
		post.destroy!
		redirect_to posts_path, notice: '削除に成功しました'
	end

	private
	def post_params
		params.require(:post).permit(:title, :content, :image, images: [])
	end

	def set_post
		@post = Post.find(params[:id])
	end
end