class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You have successfully made an account"
      redirect_to @user
    else
      flash.now[:danger] = "Something went wrong!"
      render :new
    end
  end

  def show
    @user        =  User.find(params[:id])
    @are_friends =  friends?(current_user, @user)
    @like        =  current_user.likes.build
    @comment     =  current_user.comments.build
    if current_user.sent_request?(@user)
      @request = current_user.get_friend_request(@user)
    else
      @request     =  current_user.sent_requests.build
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "You have successfully updated your account"
      redirect_to @user
    else
      flash.now[:danger] = "Something went wrong!"
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Sorry to see you go."
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end

    def friends?(current_user, user)
      request = current_user.friends.where(id: user.id)
      request.empty? ? false : true
    end
end
