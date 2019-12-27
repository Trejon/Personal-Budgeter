class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions
  has_many :budgets, through: :users
  validates :balance, presence: true

  def user_name=(name)
    self.user = User.find_or_create_by(name: name)
  end

  def user_name
    self.user ? self.user.name : nil
  end
end
