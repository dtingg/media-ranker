class UsersController < ApplicationController
  def index
    @users = User.order(:username)
  end
  
  def show
    @user = User.find_by(id: params[:id])
    
    if @user.nil?
      redirect_to users_path
      return
    end
  end
  
  def login_form
    @user = User.new
  end
  
  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{username}"
    else
      user = User.create(username: username, joined: Date.today)
      session[:user_id] = user.id
      flash[:success] = "Successfully created new user #{username} with ID #{user.id}"
    end
    redirect_to root_path
  end
  
  def logout
    if !find_current_user
      redirect_to root_path
      return
    else
      session[:user_id] = nil
      flash[:success] = "Successfully logged out"    
      redirect_to root_path
      return
    end
  end
  
  private
  
  def user_params
    return params.require(:user).permit(:username, :joined)
  end
end
