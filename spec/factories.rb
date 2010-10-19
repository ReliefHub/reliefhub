Factory.define :organization do |o|
end

Factory.sequence :project_name do |n|
  "Project #{n}"
end

Factory.define :project do |project|
  project.name { Factory.next(:project_name) }
  project.association(:organization)
end

Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |user|
  user.email                 { Factory.next :email }
  user.password              { "password" }
  user.password_confirmation { "password" }
end

Factory.define :email_confirmed_user, :parent => :user do |user|
  user.email_confirmed { true }
end

Factory.define :project_photo do |pp|
end
Factory.define :organization_photo do |op|
end
