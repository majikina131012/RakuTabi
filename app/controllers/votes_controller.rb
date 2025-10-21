class VotesController < ApplicationController

  def new
    @group = Group.find(params[:group_id])
    @vote = @group.votes.new
    @day = params[:day]
    @time = params[:time]
    @calendar_type = params[:view] || "week"
    @existing_users = @group.users
  end

  def create
    @group = Group.find(params[:group_id])
  
    new_user_name = params[:user_name].to_s.strip
    new_user = nil
    if new_user_name.present?
      new_user = @group.users.find_or_create_by(name: new_user_name)
    end
  
    existing_users = @group.users.where(id: params[:existing_user_ids])
  
    users_to_vote = ([new_user] + existing_users.to_a).compact.uniq { |u| u.id }
  
    # バリデーション：ユーザーがいない場合
    if users_to_vote.empty?
      flash.now[:alert] = "ユーザーを選択するか、新規メンバー名を入力してください"
      @vote = @group.votes.new
      @calendar_type = params[:view] || "week"
      render :new
      return
    end
  
    # バリデーション：投票ステータスが入力されていない場合
    if params[:days].blank?
      flash.now[:notice] = "少なくとも1日分の投票ステータスを選択してください"
      @vote = @group.votes.new
      @calendar_type = params[:view] || "week"
      render :new
      return
    end
  
    users_to_vote.each do |user|
      params[:days].each do |day, status_str|
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

    @vote_days = @group.votes
    .select(:day, :time)
    .distinct
    .order(:day, :time)

    @votes_by_day = {}

    @vote_days.each do |vote_day|
    votes = @group.votes.includes(:user)
          .where(day: vote_day.day, time: vote_day.time)

    @votes_by_day[[vote_day.day, vote_day.time]] = {
    maru: votes.select { |v| v.status == "◯" }.map { |v| v.user.name },
    sankaku: votes.select { |v| v.status == "△" }.map { |v| v.user.name },
    batsu: votes.select { |v| v.status == "✕" }.map { |v| v.user.name }
    }
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:day, :time, :user_id, :start_time, :status)
  end

end
