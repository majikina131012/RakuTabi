class User < ApplicationRecord

  belongs_to :group
  has_many :votes

  validates :name, presence: true, uniqueness: { scope: :group_id }, length: { maximum: 10 }
  validates :group_id, presence: true

  
  has_many :shares

  has_many :item_checks
  has_many :items, through: :item_checks

end
