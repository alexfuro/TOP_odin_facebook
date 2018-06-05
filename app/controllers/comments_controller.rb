class CommentsController < ApplicationController
  def create
    if current_user.comments.create(comment_params)
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
