class Group < ApplicationRecord

  has_many :users
  has_many :events

  validates :name, presence: true
  


end
