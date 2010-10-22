class Donation < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  acts_as_amazon_payment
end
