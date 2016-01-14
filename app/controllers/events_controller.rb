class EventsController < ApplicationController
  def index
    team_id = params[:team_id]
    limit   = 5

    @result = Hash.new
    # 取出动态
    events = Event.where("team_id = ?", team_id).order(created_at: :desc).limit(limit)
    for event in events
      # 按时间分组
      time = Time.parse(event.created_at.strftime('%Y-%m-%d'))
      if @result.has_key?(time)
        @result[time].push(event)
      else
        @result[time] = [event]
      end
    end
    # 是否加载更多
    @load_more = events.length == limit
  end
end
