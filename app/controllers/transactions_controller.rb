class TransactionsController < ApplicationController
  before_action :require_login, :get_transaction

  def new
    if logged_in?
      id = params[:account_id]
      id && @account = Account.find_by(id: params[:account_id])
        @transaction = Transaction.new
      else
        redirect_to root_path
      end
  end

  def index
    id = current_user.id
    if id && @user = User.find_by_id(id)
      @accounts = @user.accounts
      @transactions = @user.transactions
    else
      redirect_to root_path
    end
  end

  def show
  end

  def edit
  end

  def create
    if params[:transaction][:price].present?
    @user = current_user
    id = params[:transaction][:account_id]
    @account = Account.find_by_id(id)

    @transaction = @account.transactions.build(transaction_params.merge(user_id: @user.id))
    if @transaction.save
      redirect_to transaction_path(@transaction), notice:@transaction.make_transaction
    else
      render :new, notice: "#{@transaction.description} was not made."
      @transaction = Transaction.create(transaction_params)
    end
    else
      redirect_to new_transaction_path
    end
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to transaction_path(@transaction)
    else
      render :edit
    end
  end

  def destroy
    @transaction.delete
    redirect_to transactions_path
  end

  private

  def transaction_params
    params.require(:transaction).permit(:description, :date, :price, :location, :category, :necessity, :user_name, :account_name, :account_id, :budget_id)
  end

  def set_transaction_if_nested
    @transaction = Transaction.find_by_id(params[:account_id]) if params[:account_id]
  end

  def get_transaction
    @transaction = Transaction.find_by_id(params[:id])
  end
end
