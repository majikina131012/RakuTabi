class UsersController < ApplicationController

  def create
    @group = Group.find(params[:group_id])
    @user = User.new(user_params)
    @user.group_id = @group.id
    @user.save
    redirect_to group_path(@user.group_id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :group_id)
  end

end
