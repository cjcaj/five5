class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && !!user.authenticate(params[:session][:password])
      log_in user
      redirect_to username_show_path(user.username)
    else
      @error = "Invalid username/password"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
