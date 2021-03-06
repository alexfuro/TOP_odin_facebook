class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts   = current_user.feed
    @post    = current_user.posts.build
    @like    = current_user.likes.build
    @comment = current_user.comments.build
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      flash[:success] = "Post created successful"
      redirect_to posts_path
    else
      flash[:danger] = "Oh no"
      redirect_to posts_path
    end
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
end
