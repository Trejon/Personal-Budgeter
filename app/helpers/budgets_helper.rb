module BudgetsHelper
  def budgets_header(user)
    if @user
      "#{@user.name}'s active budgets:"
    else
      "All user budgets:"
     end
   end
end
