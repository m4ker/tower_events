class EventsController < ApplicationController
  def index
    team_id = params[:team_id]
    limit   = 5

    events = Event.find_latest_events(team_id, limit)

    @result = Event.by_day(events)
    # 是否加载更多
    @load_more = events.length == limit
  end

  def load_more
    last_id = params[:last_id]
    team_id = params[:team_id]
    limit   = 5

    events = Event.find_events_before(team_id, last_id, limit)
    render :json => events.map { |event| event.as_json(:methods => [:to_action, :absdate, :day, :date, :time, :project]) }

    #format.json do
    #  render :json => @contacts.map { |contact| {:id => contact.id, :name => contact.name} }
    #end
  end
end
