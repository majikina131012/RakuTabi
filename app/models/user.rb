class User < ApplicationRecord

  validates :name, presence: true
  validates :group_id, presence: true

  belongs_to :group
  has_many :item_checks
  has_many :items, through: :item_checks

end
