class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    if current_user.likes.create(likes_params)
      redirect_to request.referrer || posts_path
    else
      flash.now[:danger] = "Something went wrong"
      redirect_to request.referrer || posts_path
    end
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_to posts_path
  end

  private
    def likes_params
      params.require(:like).permit(:post_id)
    end
end
