class UsersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @user = User.new(user_params)
    @user.group_id = @group.id
    if @user.save
      # 🔽 グループ内の全アイテムに対して ItemCheck を作成
      @group.items.each do |item|
        ItemCheck.create!(item: item, user: @user, is_ok: false)
      end

      redirect_to group_path(@group.id)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :group_id)
  end
end