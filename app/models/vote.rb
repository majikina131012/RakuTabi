class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status, presence: true
  validates :name, presence: true

  enum status: { circle: 0, triangle: 1, cross: 2 } 

end
