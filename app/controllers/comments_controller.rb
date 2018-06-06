class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.create(comment_params)
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to posts_path
    else
      flash[:danger] = "Something busted!"
      render posts_path
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :post_id)
    end
end
