class Comment < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates_presence_of :body
  validates_presence_of :project_id
  validates_presence_of :user_id
end
