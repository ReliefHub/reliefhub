class Organization < ActiveRecord::Base
  def address
    [:street1, :street2, :city, :state, :zip, :country].map {|field| self.send(field) }.reject(&:blank?).join(', ')
  end
  
  def projects_count 
    0
  end
end
