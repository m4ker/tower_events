class Todo < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  #belongs_to :owner
  has_many :comments
end
