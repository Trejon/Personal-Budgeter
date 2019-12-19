class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def home
    if current_user
      redirect_to user_path(current_user)
    else
      redirect_to signup_path
    end
  end

  def create
    @user = User.find_by(name: params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      redirect_to signin_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end

  def create_facebook
    user = User.from_omniauth(env["omniauth.auth"])
    log_in user
    redirect_back_or user
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
