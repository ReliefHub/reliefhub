class Donation < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates_presence_of :amount
  validates_presence_of :project
end
