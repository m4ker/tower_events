require 'rails_helper'
RSpec.describe Event, type: :model do
  fixtures :all

  before(:all) do
  end

  # 测试关联
  it "relations" do
    event = Event.find(1)
    expect(event.team.name).to eq('m4b')
    expect(event.project.name).to eq('snakesofchina')
    expect(event.user.name).to eq('maker')
  end

  # 测试消息
  it "to_action" do
    event_1 = Event.find(1)
    event_2 = Event.find(2)
    event_9 = Event.find(9)
    expect(event_1.to_action).to eq('创建了项目')
    expect(event_2.to_action).to eq('创建了任务')
    expect(event_9.to_action).to eq('回复了任务')
  end

  # 最新动态
  it "find_latest_events" do
    event_16 = Event.find(16)
    events = Event.find_latest_events(1, 1)
    expect(events).to include(event_16)
    expect(events.length).to eq(1)
  end

  # 动态按日分组
  it "by_day" do
    events = Event.find_latest_events(1, 10)
    result = Event.by_day(events)
    #flag = true;
    result.each do |key,value|
      value.each do |event|
        expect(event.created_at.strftime('%Y-%m-%d')).to eq(key.strftime('%Y-%m-%d'))
      end
    end
    expect(result.length).to eq(3)
  end

  # 动态加载
  it "find_events_before" do
    events = Event.find_events_before(1, 11, 1)
    expect(events[0].id).to eq(10)
  end

end
