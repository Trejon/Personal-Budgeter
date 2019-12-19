class Budget < ApplicationRecord
  belongs_to :user
  has_many :accounts, through: :users
  has_many :transactions, through: :users
  validates :limit, presence: true
  validates :start, presence: true
  validates :end, presence: true

  scope :active_budgets, -> { where("? BETWEEN start AND end", Time.now.to_date) }

  def user_name=(name)
    self.user = User.find_or_create_by(name: name)
  end

  def user_name
    self.user ? self.user.name : nil
  end

  def overspent
    self.limit < 0
  end
end
