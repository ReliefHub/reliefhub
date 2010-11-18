class Donation < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates_presence_of :amount
  validates_presence_of :project

  def transaction_amount=(currency_and_amount)
    if currency_and_amount =~ /^USD ([0-9]+)$/
      self.amount = $1
    end
  end
end
