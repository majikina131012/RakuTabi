class User < ApplicationRecord

  belongs_to :group
  has_many :shares

  validates :name, presence: true
  validates :group_id, presence: true

  belongs_to :group
  has_many :item_checks
  has_many :items, through: :item_checks

end
