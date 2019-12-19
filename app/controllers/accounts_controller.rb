class AccountsController < ApplicationController
  before_action :require_login

  def index
    id = current_user.id
    if @user = User.find_by_id(id)
      @accounts = @user.accounts
    else
      redirect_to root_path
    end
  end

  def show
    @account = Account.find_by_id(params[:id])
    if @account
      @transactions = @account.transactions
    end
  end

  def new
    @account = Account.new
  end

  def edit
    @account = Account.find_by_id(params[:id])
  end

  def create
    @user = User.find_by_id(session[:user_id])
    @account = @user.accounts.build(account_params)
    if @account.save
      redirect_to account_path(@account)
    else
      render :new
    end
  end

  def update
    @account = Account.find_by_id(params[:id])
    if @account.update(account_params)
      redirect_to account_path(@account)
    else
      render :edit
    end
  end

  def destroy
    @account = Account.find_by(params[:id])
    @account.delete
    redirect_to accounts_path
  end

  private

  def account_params
    params.require(:account).permit(:name, :credit_account, :debit_account, :balance, :user_name, :transaction_id)
  end

  def set_account
    @account = Account.find_by_id(params[:user_id]) if params[:user_id]
  end
end
