class EventsController < ApplicationController

  # 动态列表
  # TODO: 权限验证
  def index
    begin
      team_id = params[:team_id]
      limit   = 5

      raise ArgumentError, "last_id required" unless team_id

      # 检查team
      team = Team.find(team_id)

      events = Event.find_latest_events(team_id, limit)
      @result = Event.by_day(events)
      # 是否加载更多
      @load_more = events.length == limit
    rescue Exception
      render :text => 'Not Found', :status => '404'
    end
  end

  # 持续加载
  # TODO: 权限验证
  def load_more
    begin
      last_id = params[:last_id]
      team_id = params[:team_id]
      limit   = 5

      raise ArgumentError, "last_id required" unless last_id
      raise ArgumentError, "last_id required" unless team_id

      team = Team.find(team_id)

      events = Event.find_events_before(team_id, last_id, limit)
      render :json => events.map { |event| event.as_json(:methods => [:to_action, :absdate, :day, :date, :time, :project]) }
    rescue Exception
      render :text => 'Not Found', :status => '404'
    end
  end
end
