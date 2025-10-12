class VotesController < ApplicationController

  def new
    @group = Group.find(params[:group_id])
    @vote = @group.votes.new
    @day = params[:day]
    @time = params[:time]
    @calendar_type = params[:view] || "week"
    @existing_users = @group.users
  end
  
  # def create
  #   group = Group.find(params[:group_id])
  #   user = group.users.find_or_create_by(name: params[:user_name])
  #   @vote  = group.votes.new(vote_params)
  #   @vote.group_id = group.id
  #   @vote.user_id = user.id
  #   if @vote.save!
  #     redirect_to group_votes_path(group.id)
  #   else
  #     render :new
  #   end
  # end

  def create
    @group = Group.find(params[:group_id])
  
    # 新規ユーザー名
    new_user_name = params[:user_name].to_s.strip
    new_user = nil
    if new_user_name.present?
      # グループ内で重複しないようスコープ付きで検索・作成
      new_user = @group.users.find_or_create_by(name: new_user_name)
    end
  
    # 既存ユーザー選択
    existing_users = @group.users.where(id: params[:existing_user_ids])
  
    # 投票対象ユーザーを一意にまとめる
    users_to_vote = ([new_user] + existing_users.to_a).compact.uniq { |u| u.id }
  
    users_to_vote.each do |user|
      params[:days].each do |day, status_str|
        # 同じ日付・同じユーザーの投票が存在しなければ作成、既存ならstatusを更新
        vote = @group.votes.find_or_initialize_by(user: user, day: day)
        vote.status = status_str
        vote.save!
      end
    end
  
    redirect_to group_votes_path(@group), notice: "投票を登録しました"
  end
  

  def index
    @group = Group.find(params[:group_id])

    @votes = Vote.where(group_id: @group.id)
                .where("day >= ?", Date.current)
                .where("day < ?", Date.current >> 3)
                .order(day: :desc)

    @top_votes = Vote.where(group_id: @group.id, status: "◯")
    .select("day, COUNT(*) as votes_count")
    .group(:day)
    .order("votes_count DESC")
    .limit(3)
end

  private

  def vote_params
    params.require(:vote).permit(:day, :time, :user_id, :start_time, :status)
  end

end
