class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @requests = current_user.received_requests.pending
  end

  def create
    @user = current_user
    @user.sent_requests.build(requested_id: params[:friend_request][:requested_id])
    if @user.save!
      flash[:success] = "friend request sent!"
      redirect_to user_path(params[:friend_request][:requested_id])
    else
      flash.now[:danger] = "Oh no!"
      render user_path(params[:friend_request][:requested_id])
    end
  end

  def update
    request = FriendRequest.find(params[:id])
    if request.update(request_params)
      flash[:success] = "You have a new friend!"
      redirect_to friend_requests_path
    else
      flash.now[:success] = "Error"
      render friend_requests_path
    end
  end
  def destroy
    FriendRequest.find(params[:id]).destroy
    redirect_to request.referrer || users_path
  end

  private
    def request_params
      params.require(:friend_request).permit(:accepted)
    end
end
