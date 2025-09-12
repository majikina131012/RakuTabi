class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status, presence: true
  validates :name, presence: true

  enum status: { ok: 0, maybe: 1, no: 2 }

end
