class UsersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    # 入力欄に「Aさん、Bさん」など複数名が入ることを想定
    names = params[:user][:name]
              .split(/[\s,、。]+/)  # 空白・カンマ・句読点で分割
              .reject(&:blank?)     # 空要素を除外
  
    created_users = []
  
    names.each do |name|
      user = @group.users.build(name: name)
      created_users << user if user.save
    end
  
    if created_users.any?
      flash[:notice] = "#{created_users.map(&:name).join('、')} を追加しました"
    else
      flash[:notice] = "ユーザーを追加できませんでした。"
    end
  
    redirect_to group_path(@group)
  end

  def edit
    @group = Group.find(params[:group_id])
    @user = User.find(params[:id])
  end

  def update
    @group = Group.find(params[:group_id])
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザーの更新に成功しました"
      redirect_to group_path(@group.id)
    else
      render :edit
    end  
  end


  private

  def user_params
    params.require(:user).permit(:name, :group_id)
  end
end