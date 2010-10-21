
[Photo, Project, Organization].each(&:delete_all)
Factory.create :organization
Factory.create :organization

Project.delete_all
40.times do
  Factory.create :project
end

User.delete_all
10.times do
  Factory.create :user
end