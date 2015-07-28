class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).order('created_at DESC')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to username_show_path(@user.username)
    else
      render 'new'
    end
  end

  def update
    user = User.find_by(username: params[:username])
    if params[:image_id].present?
      preloaded = Cloudinary::PreloadedFile.new(params[:image_id])
      raise "Invalid upload signature" if !preloaded.valid?
      user.update_attributes(picture: preloaded.identifier)
    end
    render json: {image_id: user.picture}
  end

  def show
    @user = User.find_by(username: params[:username])
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation, :location)
  end

end
