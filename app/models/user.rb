class User < ApplicationRecord

  validates :name, presence: true
  validates :group_id, presence: true

  belongs_to :group

end
