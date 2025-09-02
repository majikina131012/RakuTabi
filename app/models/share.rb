class Share < ApplicationRecord

  belongs_to :expense
  belongs_to :user

  validates :user_id, presence: true
  validates :expense_id, presence: true

end
