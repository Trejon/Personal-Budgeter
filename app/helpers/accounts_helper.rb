module AccountsHelper
  def accounts_header(user)
    if @user
      "#{@user.name}'s accounts:"
    else
      "#{@account.name}'s account:"
     end
   end
end
