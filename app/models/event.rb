class Event < ApplicationRecord
  belongs_to :group
  has_many :votes, dependent: :destroy
  has_many :schedules, dependent: :destroy

  validates :title, presence: true

end
