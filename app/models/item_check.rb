class ItemCheck < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :is_ok, inclusion: { in: [true, false] }
end
