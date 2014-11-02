class SessionsController < ApplicationController
  def new
    # flash[:notice] = 'hi there'
  end

  def create
    user = User.find_by(username: params[:username])
    # binding.pry
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome, #{user.username}!"
      redirect_to list_user_path(user)
    else
      flash[:error] = "There's something wrong with your username or password"
      redirect_to login_path
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out."
    redirect_to root_path
  end

  def list
    if logged_in?
      redirect_to list_user_path(current_user)
    else
      redirect_to login_path
    end
  end

end