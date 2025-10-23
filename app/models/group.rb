class Group < ApplicationRecord

  has_many :votes
  has_many :users, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :name, presence: true

  def optimized_settlements

    balance = Hash.new(0)

    shares = Share.joins(:expense).where(expenses: { group_id: id })

    shares.each do |share|
      balance[share.user_id] += share.pay.to_f
      balance[share.user_id] -= share.must_pay.to_f
    end

    creditors = balance.select { |_, v| v > 0 }.to_a.sort_by { |_, v| -v } # 多く払った人
    debtors   = balance.select { |_, v| v < 0 }.to_a.sort_by { |_, v| v }  # 払い足りない人

    settlements = []

    debtors.each do |debtor_id, debt_amount|
      debt_amount = -debt_amount

      creditors.each_with_index do |(creditor_id, credit_amount), i|
        next if credit_amount <= 0

        payment = [debt_amount, credit_amount].min

        settlements << {
          from: User.find(debtor_id),
          to: User.find(creditor_id),
          amount: payment.round
        }

        balance[debtor_id] += payment
        balance[creditor_id] -= payment

        creditors[i][1] -= payment
        debt_amount -= payment

        break if debt_amount <= 0
      end
    end

    settlements
  end
  
end
