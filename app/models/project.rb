class Project < ActiveRecord::Base
  belongs_to :organization
  has_many   :project_photos, :foreign_key => :owner_id
  has_many   :donations

  accepts_nested_attributes_for :project_photos

  delegate :name, :address, :to => :organization, :prefix => true

  scope :by_updated_date, order('updated_at DESC')

  def photo_url size
    photo.file.url(size)
  end

  def photo
    project_photos.first
  end

  def amount_raised
    donations.sum(:amount)
  end

  def percent_raised
    return 0 if goal.to_i == 0
    (amount_raised / goal.to_f) * 100
  end

  def self.statuses
    ['Approved', 'Closed', 'Pending', 'Suspended']
  end
end
