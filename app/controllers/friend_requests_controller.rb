class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @requests = current_user.received_requests.pending
  end

  def create
    current_user.sent_requests.build(request_params)
    if current_user.save!
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
      reciprocate(params[:id]) if params[:friend_request][:accepted] == "accept"
      flash[:success] = "We have recorded your answer"
      redirect_to friend_requests_path
    else
      flash.now[:success] = "Error"
      render friend_requests_path
    end
  end

  def destroy
    requestor = FriendRequest.find(params[:id]).requestor_id
    requested = FriendRequest.find(params[:id]).requested_id

    if FriendRequest.find(params[:id]).accepted
      reciprocate_destroy(requestor, requested)
    end
    FriendRequest.find(params[:id]).destroy
    redirect_to request.referrer || users_path
  end

  private
    def request_params
      params.require(:friend_request).permit(:requested_id,:accepted)
    end
    def reciprocate(request_id)
      requestor = FriendRequest.find(request_id).requestor_id
      requested = FriendRequest.find(request_id).requested_id
      #flip requested and requestor to create other side of fiendship
      FriendRequest.create(requestor_id: requested, requested_id: requestor, accepted: true)
    end
    def reciprocate_destroy(requestor, requested)
      #flip requested and requestor to erase other side of fiendship
      FriendRequest.find_by(requestor_id: requested, requested_id: requestor, accepted: true).destroy
    end
end
