class Expense < ApplicationRecord
  
  belongs_to :payer, class_name: "User"
  belongs_to :group
  has_many :shares, dependent: :destroy
  has_many :users, through: :shares

  validates :payer_id, presence: true
  validates :group_id, presence: true
  validates :amount, presence: true
  validates :description, presence: true
end
