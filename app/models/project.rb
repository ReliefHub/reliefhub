class Project < ActiveRecord::Base
  belongs_to :organization
  has_many   :project_photos, :foreign_key=>:owner_id

  accepts_nested_attributes_for :project_photos
  
  has_attached_file :photo, :styles => {:thumb => ["100x100#", :png]}
  
  scope :by_raised_amount, order('raised DESC')
  
  def thumbnail_url
    photo.url(:thumb)
  end
  
  def percent_completed
    return 0 if raised == 0 || goal == 0
    return ((raised / goal) * 100).ceil.to_i
  end
    
  def funds_received
    raised
  end
end
