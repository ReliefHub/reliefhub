class Donation < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates_presence_of :amount
  validates_presence_of :project

  def transaction_amount=(currency_and_amount)
    if currency_and_amount =~ /^\s*(USD)?\s*[-+]?([0-9]*\.[0-9]+|[0-9]+)$/
#      amount = $2
      self.amount = $2
    end
  end
end
