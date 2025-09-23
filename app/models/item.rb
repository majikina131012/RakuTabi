class Item < ApplicationRecord
  belongs_to :group
  has_many :item_checks
  has_many :users, through: :item_checks

  validates :name, presence: true
end
