class UsersController < ApplicationController
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
    @user = User.find(params[:id])
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
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end
end
