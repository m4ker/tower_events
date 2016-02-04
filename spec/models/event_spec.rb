require 'rails_helper'
RSpec.describe Event, type: :model do
  fixtures :all
  before(:all) do
    @event = Event.find(1);
  end
  it "relations" do
    expect(@event.team.name).to eq('m4b')
    expect(@event.project.name).to eq('snakesofchina')
    expect(@event.user.name).to eq('maker')
  end
end
