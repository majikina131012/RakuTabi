class Group < ApplicationRecord

  has_many :users
  has_many :votes

  validates :name, presence: true
  


end
