class VotesController < ApplicationController

  def new
    @group = Group.find(params[:group_id])
    @vote = @group.votes.new
    @day = params[:day]
    @time = params[:time]
  end
  
  def create
    group = Group.find(params[:group_id])
    user = group.users.find_or_create_by(name: params[:user_name])
    @vote  = group.votes.new(vote_params)
    @vote.group_id = group.id
    @vote.user_id = user.id
    if @vote.save!
      redirect_to group_votes_path(group.id)
    else
      render :new
    end
  end

  def index
    @group = Group.find(params[:group_id])
    @votes = Vote.where(group_id: @group.id)
                .where("day >= ?", Date.current)
                .where("day < ?", Date.current >> 3)
                .order(day: :desc)
  end

  private

  def vote_params
    params.require(:vote).permit(:day, :time, :user_id, :start_time, :status)
  end

end
