class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :user
  belongs_to :budget
  has_many :budgets, through: :users
  validates :price, presence: true
  validates :description, presence: true
  validate :account_balance_is_greater
  scope :necessity, -> { where(necessity: true) }
  # before_validation :make_transaction

  def account_balance_is_greater
    if self.account.balance < self.price
      self.errors.add :account, "balance must be greater than transaction total"
    end
  end

  def account_name=(name)
    self.account = Account.find_or_create_by(name: name)
  end

  def account_name
    self.account ? self.account.name : nil
  end

  def user_name=(name)
    self.user = User.find_or_create_by(name: name)
  end

  def user_name
    self.user ? self.user.name : nil
  end

  def make_transaction
    if account_has_insufficient_funds? && budget_has_insufficient_funds?
      "Sorry, you do not have enough money in your account to complete the #{self.description} transaction."
      "You would be overspending on your budget with the #{self.description} transaction."
    elsif account_has_insufficient_funds?
        "Sorry, you do not have enough money in your account to complete the #{self.description} transaction."
    elsif budget_has_insufficient_funds?
      self.budget.update(limit: self.budget.limit -= self.price)
      self.account.update(balance: self.account.balance -= self.price)
      "You're overspending on your budget with the #{self.description} transaction."
    else
      self.account.update(balance: self.account.balance -= self.price)
      self.budget.update(limit: self.budget.limit -= self.price)
      "Your #{self.description} transaction was logged successfully!"
    end
  end

  def account_has_insufficient_funds?
    self.account.balance < self.price
  end

  def budget_has_insufficient_funds?
    self.budget.limit < self.price
  end
end
