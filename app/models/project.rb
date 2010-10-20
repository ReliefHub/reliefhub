class Project < ActiveRecord::Base
  belongs_to :organization
  has_many   :project_photos, :foreign_key=>:owner_id

  accepts_nested_attributes_for :project_photos
  
  def funds_received
    0
  end
end
