class VotesController < ApplicationController
  before_action :set_event

  def index
    render json: @event.votes.map { |v|
      {
        id: v.id,
        title: "#{v.name} (#{v.status})",
        start: v.date,
        allDay: true,
        color: vote_color(v.status)
      }
    }
  end

  def create
    @vote = @event.votes.new(vote_params)
    if @vote.save
      render json: { success: true }
    else
      render json: { success: false, errors: @vote.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def vote_params
    params.require(:vote).permit(:date, :name, :status)
  end

  def vote_color(status)
    case status
    when "ok" then "green"
    when "maybe" then "orange"
    when "no" then "red"
    end
  end
end
