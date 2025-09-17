class VotesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @vote = @event.votes.find_or_initialize_by(user_id: current_user.id)

    if @vote.update(status: params[:status])
      render json: { success: true, vote: @vote }
    else
      render json: { success: false, errors: @vote.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
