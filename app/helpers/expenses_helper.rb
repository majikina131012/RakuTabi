module ExpensesHelper
  # 支払先のユーザーを適切に表示する
  def display_recipients(expense)
    # payer 以外で支払金額があるユーザー
    recipients = expense.shares.select { |s| s.user_id != expense.payer_id && s.must_pay.to_f > 0 }.map(&:user)

    # payer にも支払っている場合は含める
    recipients_with_payer = if expense.shares.any? { |s| s.user_id == expense.payer_id && s.must_pay.to_f > 0 }
                              recipients + [expense.payer]
                            else
                              recipients
                            end

    # 表示用に「、」で連結
    recipients_with_payer.map(&:name).join("、")
  end
end
