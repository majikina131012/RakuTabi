class VotesController < ApplicationController

  def new
    @group = Group.find(params[:group_id])
    @vote = @group.votes.new
    @day = params[:day]
    @time = params[:time]
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
    group = Group.find(params[:group_id])

    # 入力された名前でユーザーを取得 or 作成
    user = group.users.find_or_create_by(name: params[:user_name])

    # daysパラメータの形: {"2025-09-20"=>"○", "2025-09-21"=>"✕", "2025-09-22"=>"△"}
    days = params[:days] || {}

    success = true
    days.each do |day, status|
      vote = group.votes.new(
        user_id: user.id,
        group_id: group.id,
        day: day,
        status: status
      )
      success &&= vote.save
    end

    if success
      redirect_to group_votes_path(group.id), notice: "投票を登録しました"
    else
      flash.now[:alert] = "投票の保存に失敗しました"
      @group = group
      render :new
    end
  end

  def index
    @group = Group.find(params[:group_id])

    @votes = Vote.where(group_id: @group.id)
                .where("day >= ?", Date.current)
                .where("day < ?", Date.current >> 3)
                .order(day: :desc)

   @top_votes = Vote.where(status: "◯")
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
