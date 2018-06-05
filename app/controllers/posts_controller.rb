class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def new
  end

  def create
    if current_user.posts.create(post_params)
      flash[:success] = "Post created successful"
      redirect_to posts_path
    else
      flash.now[:danger] = "Oh no"
      redender :new
    end
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
end
