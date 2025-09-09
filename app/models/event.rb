class Event < ApplicationRecord
  belongs_to :group
  has_many :votes
  has_many :schedules, dependent: :destroy

  validates :title, presence: true
end
