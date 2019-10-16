class UsersController < ApplicationController
  def index
    @users = User.order(:username)
  end
  
  def show
    @user = User.find_by(id: params[:id])
    
    if @user.nil?
      head :not_found
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
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      user = User.create(username: username, joined: Date.today)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end
    
    redirect_to root_path
  end
  
  def logout
    session[:user_id] = nil
    
    redirect_to root_path
  end
end
