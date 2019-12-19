class UsersController < ApplicationController
  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.create!(user_params)
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    if logged_in?
      @user = current_user
      @transactions = current_user.transactions
    else
      redirect_to root_path
    end
  end

  def update
    if logged_in?
      @user = User.find_by(id: params[:id])
      @user.update(user_params)
      if @user.save
        redirect_to user_path(@user)
      else
        render :edit
      end
    else
      redirect_to root_path
    end
  end

  def edit
    if logged_in?
      @user = User.find_by_id(params[:id])
    else
      redirect_to root_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

private

  def user_params
    params.require(:user).permit(:name, :password, :username, :uid)
  end
end
