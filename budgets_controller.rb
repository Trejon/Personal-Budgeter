class BudgetsController < ApplicationController
  before_action :require_login

  def index
    id = current_user
    if id && @user = User.find_by_id(id)
      @budgets = @user.budgets.active_budgets
    else
      redirect_to root_path
    end
  end

  def show
    @budget = Budget.find_by_id(params[:id])
  end

  def new
    if logged_in?
      @budget = Budget.new
    else
      redirect_to root_path
    end
  end

  def edit
      @budget = Budget.find_by_id(params[:id])
  end

  def create
    @user = User.find_by_id(session[:user_id])
    @budget = @user.budgets.create(budget_params)
    if @budget.save
      redirect_to budget_path(@budget)
    else
      render :new
    end
  end

  def update
    @budget = Budget.find_by_id(params[:id])
    if @budget.update(budget_params)
      redirect_to budget_path(@budget)
    else
      render :edit
    end
  end

  def destroy
    @budget = Budget.find_by_id(params[:id])
    @budget.delete
    redirect_to budgets_path
  end

  private

  def budget_params
    params.require(:budget).permit(:name, :limit, :category, :start, :end, :user_name)
  end

  def set_budget
    @budget = Budget.find_by_id(params[:id])
  end
end
