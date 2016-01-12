class EventsController < ApplicationController
  def index
    team_id = params[:team_id]
    limit   = 15

    @result = Hash.new
    events = Event.where("team_id = ?", team_id).order(created_at: :desc).limit(limit);
    for event in events
      time = event.created_at
      if @result.has_key?(time)
        @result[time].push(event)
      else
        @result[time] = [event]
      end
    end
  end
end
