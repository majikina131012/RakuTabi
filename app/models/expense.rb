class Expense < ApplicationRecord
  
  belongs_to :payer, class_name: "User"
  belongs_to :group
  has_many :shares, dependent: :destroy
  has_many :users, through: :shares


  validates :group_id, presence: true
  validates :amount, presence: true
  validates :description, presence: true
  validate :must_have_at_least_one_recipient

  def must_have_at_least_one_recipient
    if user_ids.blank? || user_ids.reject(&:blank?).empty?
      errors.add(:user_ids, "を選択してください")
    end
  end
end
