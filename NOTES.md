
users....show
<h1>Your Transactions:</h1>
<p><% @user.account.transactions.each do |transaction| %></p>
<%= link_to transaction.description, user_transactions_path(current_user.transactions) %> - $<%= '%.2f' % transaction.price %><br>
<% end %><br><br></p>


<h1>Your Accounts:</h1>
<p><% @user.accounts.each do |account| %></p>
<%= link_to account.name, account_path(@user) %> - $<%= '%.2f' % account.balance %><br>
<% end %><br><br></p>





index....transaction
<% @transactions.each do |e| %>
<ul><%= render "transaction", transaction: e %></ul>
<% end %>









class TransactionsController < ApplicationController
  before_action :logged_in?, only: [:create, :new, :edit, :update]
  before_action :set_transaction_if_nested, only[:new, :index]

  def new
    if @transaction
    @transaction = @account.transactions.build
  else
    @transaction = Transaction.new
  end
  end


  def index
    id = params[:account_id]
    if id && @account = Account.find_by_id(id)
      @transactions = @account.transactions
    else
      @transactions = Transaction.all
    end
  end

  def show
    @transaction = Transaction.find_by_id(params[:id])
  end

  def edit
    @transaction = Transaction.find_by_id(params[:id])
  end

def create
  id = params[:account_id]
  if id && @account = Account.find_by_id(id)
  @transaction = @account.transactions.build(transaction_params)
  if @transaction.save
    if @transaction.necessity
    redirect_to user_transactions_path(@user), notice:@transaction.make_transaction
  else
    redirect_to user_path(current_user), notice:@transaction.make_transaction
  end
  else
    render :new, notice: "#{@transaction.description} was not made."
    end
  else
    @transaction = Transaction.create(transaction_params)
    end
  end




  def update
    @transaction = Transaction.find_by_id(params[:id])
    if @transaction.update(transaction_params)
      redirect_to transaction_path(@transaction)
    else
      render :edit
    end
  end

  def destroy
    @transaction = Transaction.find_by(params[:id])
    @transaction.delete
    redirect_to transactions_path
  end

  private

  def transaction_params
    params.require(:transaction).permit(:description, :date, :price, :location, :category, :necessity, :user_name, :account_name, :account_id, user_attributes: [:name])
  end

  def set_transaction_if_nested
    @transaction = Transaction.find_by_id(params[:account_id]) if params[:account_id]
  end
end











<% if logged_in? %>
<% if flash[:notice] %>
   <div class="notice"><%= flash[:notice] %></div>
 <% end %>

<h1>Listing Users</h1>

<table>
  <thead>
    <tr>
      <th>Users!</th>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <% if logged_in? %>
    <% @users.each do |user| %>
      <tr>
        <td><%= user.name %></td>
        <td><%= link_to "See User Profile", user %></td>
        <% if current_user %>
        <td><%= link_to "Edit User", edit_user_path(user) %></td>
        <td><%= link_to "Remove", user, method: :delete, data: { confirm: "Are you sure?" } %></td>
      </tr>
    <% end %>
    <% end %>
  </tbody>
</table>

<br>

<%= link_to "Add New User", new_user_path %>
<% end %>
<% end %>
