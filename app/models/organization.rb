class Organization < ActiveRecord::Base
  has_many :projects
  has_many :organization_photos, :foreign_key => :owner_id

  accepts_nested_attributes_for :organization_photos

  def address
    [:street1, :street2, :city, :state, :zip, :country].map {|field| self.send(field) }.reject(&:blank?).join(', ')
  end

  delegate :count, :to => :projects, :prefix => true
end
