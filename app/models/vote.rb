class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum status: { "◯": 0, "△": 1, "✕": 2 }

end
