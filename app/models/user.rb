class User < ActiveRecord::Base
  has_many :teams, through: :members
  belongs_to :project
  has_many :events
  has_many :todos
  has_many :comments
end
