class UsersController < ApplicationController

  def create
    @group = Group.find(params[:group_id])
    @user = User.new(user_params)
    @user.group_id = @group.id
    if @user.save
      redirect_to group_path(@user.group_id)
    else
      render group_path(@users.group_id)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :group_id)
  end

end
