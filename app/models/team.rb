class Team < ActiveRecord::Base
  has_many: user, through: :members
  has_many: products
  has_many: events
end
