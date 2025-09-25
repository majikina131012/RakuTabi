class ExpensesController < ApplicationController
  
  def create
    @group = Group.find(params[:group_id])
    @expense = Expense.new(expense_params)
    @expense.group_id = @group.id
    user_ids = params[:expense][:user_ids].reject(&:blank?).map(&:to_i)
  
    if @expense.save
      flash[:notice] = "登録しました"
      share_amount = @expense.amount / user_ids.size.to_f
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
      @expenses = @group.expenses.order(created_at: :desc).limit(3)
      @members = @group.users
      render "groups/show"
    end
  end

  def index
    @group = Group.find(params[:group_id])
    @expenses =  @group.expenses
  end

  def edit
    @group = Group.find(params[:group_id])
    @members = @group.users
    @expense =  Expense.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:group_id])
    @expense =  Expense.find(params[:id])
    if @expense.update(expense_params)
      flash[:notice] = "変更しました"
      redirect_to group_path(@group.id)
    else
      @members = @group.users
      render :edit
    end
  end

  def destroy
    group = Group.find(params[:group_id])
    expense = Expense.find(params[:id])
    expense.destroy
    redirect_to group_path(group.id)
  end

  def destroy_all
    @group = Group.find(params[:group_id])
    @group.expenses.destroy_all
    redirect_to group_path(@group.id), notice: "全ての精算データをリセットしました"
  end
  
  private

  def expense_params
    params.require(:expense).permit(:amount, :description, :payer_id, user_ids: [])
  end

end
