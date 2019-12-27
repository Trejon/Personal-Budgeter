class User < ApplicationRecord
  has_secure_password
  has_many :accounts, dependent: :destroy
  has_many :budgets, dependent: :destroy
  has_many :transactions, dependent: :destroy
  validates :name, uniqueness: true

  def self.from_omniauth(auth)
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
        u.password = "password123"
      end

      session[:user_id] = @user.id
      render 'sessions/home'
  end

  def total_balance
    accounts = self.accounts
    accounts.map(&:balance).inject(0, &:+)
  end

    def users_transactions
      id = params[:account_id]
      if id && @account = Account.find_by_id(id)
        @transactions = @account.transactions
      end
    end
  end
