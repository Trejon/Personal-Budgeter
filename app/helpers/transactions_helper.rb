module TransactionsHelper
def transactions_header(user)
  if @user
    "#{@user.name}'s transactions:"
  else
    "All user transactions:"
   end
 end
end
