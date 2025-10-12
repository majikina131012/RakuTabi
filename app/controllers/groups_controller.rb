class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_path(@group.id)
    else
      render :new
    end
  end

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @user = User.new
    @expense = Expense.new
    @members = @group.users
    @settlements = @group.optimized_settlements
    @expenses = @group.expenses.order(created_at: :desc).limit(3)
  end

  def error
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

end
