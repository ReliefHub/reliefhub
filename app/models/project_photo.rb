class ProjectPhoto < Photo
  belongs_to :project, :foreign_key => :owner_id
end
