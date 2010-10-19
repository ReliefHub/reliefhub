Factory.define :organization do |o|
end

Factory.sequence :project_name do |n|
  "Project #{n}"
end

Factory.define :project do |p|
  p.add_attribute(:name) { Factory.next(:project_name) }
  p.organization         { |o| o.association(:organization) }
end
