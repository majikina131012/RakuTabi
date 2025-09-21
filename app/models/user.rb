class User < ApplicationRecord

  belongs_to :group
  has_many :votes

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: { scope: :group_id }
  validates :group_id, presence: true

  

end
