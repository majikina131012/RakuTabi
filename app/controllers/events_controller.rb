class EventsController < ApplicationController

  def index
    @group = Group.find(params[:group_id])
    @events = @group.events
    respond_to do |format|
      format.html
      format.json { render 'calendar' }
    end
  end

end
