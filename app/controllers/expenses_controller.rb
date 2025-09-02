class ExpensesController < ApplicationController
  
  def create
    @group = Group.find(params[:group_id])
    @expense = Expense.new(expense_params)
    @expense.group_id = @group.id
    user_ids = @group.user_ids
    if @expense.save
      # user_ids = params[:expense][:user_ids].reject(&:blank?).map(&:to_i)
      share_amount = @expense.amount / user_ids.count
      user_ids.each do |user_id|
        @expense.shares.create!(
          user_id: user_id,
          must_pay: share_amount,
          pay: user_id == @expense.payer_id ? @expense.amount : 0,
          pay_to_user_id: @expense.payer_id == user_id ? nil : @expense.payer_id
        )
      end
      redirect_to group_path(@group.id)
    else
      redirect_to error_path
    end
  end
  
  private

  def expense_params
    params.require(:expense).permit(:amount, :description, :payer_id, user_ids: [])
  end

end
