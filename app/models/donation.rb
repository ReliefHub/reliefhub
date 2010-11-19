class Donation < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates_presence_of :amount
  validates_presence_of :project
  validates_presence_of :transaction_id

  def transaction_amount=(currency_and_amount)
    currency = parse(currency_and_amount).first
    if currency == 'USD'
      amount = parse(currency_and_amount).last.to_i
    else
      amount = currency.to_i
    end
    self.amount = amount unless amount == 0
  end

  def parse(currency_and_amount)
    @parsed ||= currency_and_amount.split
  end
end
