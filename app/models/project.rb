class Project < ActiveRecord::Base
  belongs_to :organization
  has_many   :project_photos, :foreign_key=>:owner_id
  has_many   :donations

  accepts_nested_attributes_for :project_photos
  
  scope :by_updated_date, order('updated_at DESC')
  
  def thumbnail_url
    photo.file.url(:thumb)
  end
  
  def photo
    project_photos.first
  end
  
  def raised
    return 0 if donations.size.zero?
    donations.map(&:amount).compact.sum 
  end
  
  def percent_completed
    return 0 if raised == 0 || goal == 0
    return ((raised / goal) * 100).ceil.to_i
  end
    
  def self.statuses
    [ 'Approved', 'Closed', 'Pending', 'Suspended']
  end
end
