class User < ApplicationRecord

  belongs_to :group
  has_many :shares

  validates :name, presence: true
  validates :group_id, presence: true

end
