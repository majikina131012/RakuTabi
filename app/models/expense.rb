class Expense < ApplicationRecord

  belongs_to :group
  has_many :shares

  validates :payer_id, presence: true
  validates :group_id, presence: true
  validates :amount, presence: true
  validates :description, presence: true
end
