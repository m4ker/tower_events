class Event < ActiveRecord::Base
  belongs_to :team
  belongs_to :project
  belongs_to :user

  def to_action
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
      "给 %user_to 指派了任务"
    when "todo.time"
      "将任务完成时间从 %date_from 修改为 %date_to"
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

  def find_group_by_day(team_id, from_time, limit = 5)

  end

  def find_from_time(from_time, limit = 5)

  end
end
