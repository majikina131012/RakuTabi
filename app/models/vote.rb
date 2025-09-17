class Vote < ApplicationRecord
  belongs_to :user

  enum status: { "◯": 0, "△": 1, "✕": 2 }

end
