class ExpensesController < ApplicationController
  
  def create
    @group = Group.find(params[:group_id])
    @expense = Expense.new(expense_params)
    @expense.group_id = @group.id
    user_ids = params[:expense][:user_ids].reject(&:blank?).map(&:to_i)
  
    if @expense.save
      flash[:notice] = "登録しました"
  
      # 受取人だけで割る（payer を受取人に含めないケースもある）
      share_amount = @expense.amount / user_ids.size.to_f
  
      # 受取人の shares を作成
      user_ids.each do |user_id|
        @expense.shares.create!(
          user_id: user_id,
          must_pay: share_amount,
          pay: 0,
          pay_to_user_id: @expense.payer_id == user_id ? nil : @expense.payer_id
        )
      end
  
      # payer が受取人リストに含まれていなければ payer 用の share を作る
      unless user_ids.include?(@expense.payer_id)
        @expense.shares.create!(
          user_id: @expense.payer_id,
          must_pay: 0,
          pay: @expense.amount,
          pay_to_user_id: nil
        )
      else
        # payer が受取人に含まれている場合は、既に作った share の pay を設定する
        payer_share = @expense.shares.find_by(user_id: @expense.payer_id)
        payer_share.update!(pay: @expense.amount) if payer_share && payer_share.pay.to_f == 0
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

  def detail
  end

  def edit
    @group = Group.find(params[:group_id])
    @members = @group.users
    @expense =  Expense.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:group_id])
    @expense = @group.expenses.find(params[:id])
    user_ids = params[:expense][:user_ids].reject(&:blank?).map(&:to_i)
  
    if @expense.update(expense_params)
      # 既存の shares を全削除
      @expense.shares.destroy_all
  
      # 割り勘計算
      if user_ids.any?
        share_amount = @expense.amount / user_ids.size.to_f
  
        # 受取人の shares を作成
        user_ids.each do |user_id|
          @expense.shares.create!(
            user_id: user_id,
            must_pay: share_amount,
            pay: 0,
            pay_to_user_id: @expense.payer_id == user_id ? nil : @expense.payer_id
          )
        end
      end
  
      # payer 用の share を作成（または更新）
      unless user_ids.include?(@expense.payer_id)
        @expense.shares.create!(
          user_id: @expense.payer_id,
          must_pay: 0,
          pay: @expense.amount,
          pay_to_user_id: nil
        )
      else
        payer_share = @expense.shares.find_by(user_id: @expense.payer_id)
        payer_share.update!(pay: @expense.amount) if payer_share && payer_share.pay.to_f == 0
      end
  
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
