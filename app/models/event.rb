class Event < ActiveRecord::Base
  belongs_to: team
  belongs_to: project
  belongs_to: user
end
