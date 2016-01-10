class Project < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  has_many :users
  has_many :todos
  has_many :events
end
