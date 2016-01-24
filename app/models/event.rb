require 'json'

class Event < ActiveRecord::Base
  belongs_to :team
  belongs_to :project
  belongs_to :user

  def to_action
    if self.data
      data = JSON.parse(self.data);
    else
      data = nil;
    end
    case self.object + '.' + self.action
    when "project.create"
      "创建了项目"
    when "project.delete"
      "删除了项目"
    when "todo.create"
      "创建了任务"
    when "todo.delete"
      "删除了任务"
    when "todo.start"
      "开始处理这条任务"
    when "todo.resume"
      "暂停处理这条任务"
    when "todo.move"
      "移动了任务"
    when "todo.designate"
      "给 #{data.user_to} 指派了任务"
    when "todo.time"
      "将任务完成时间从 #{data.date_from} 修改为 #{data.date_from}"
    when "todo.complete"
      "完成了任务"
    when "todo.active"
      "重新打开了任务"
    when "todo.comment.create"
      "回复了任务"
    when "todo.comment.delete"
      "删除了回复"
    else
      raise "未定义的action: " + self.object + '.' + self.action
    end
  end

  def absdate
    self.created_at.strftime('%Y-%m-%d')
  end

  def date
    self.created_at.strftime('%-m/%-d')
  end

  def day
    self.created_at.strftime('%A')
  end

  def time
    self.created_at.strftime('%k:%S')
  end

  def self.find_latest_events(team_id, limit = 5)
    Event.where("team_id = ?", team_id).order(created_at: :desc).limit(limit)
  end

  def self.by_day(events)
    result = Hash.new
    for event in events
      # 按时间分组
      time = Time.parse(event.created_at.strftime('%Y-%m-%d'))
      if result.has_key?(time)
        result[time].push(event)
      else
        result[time] = [event]
      end
    end
    result
  end

  def self.find_events_before(team_id, id, limit = 5)
    Event.where("team_id = ? AND id < ?", team_id, id).order(created_at: :desc).limit(limit);
  end

end
