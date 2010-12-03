Factory.define :organization do |organization|
  organization.name { Faker::Company.name }
end

Factory.define :project do |project|
  project.association(:organization)
  project.name           { Faker::Company.catch_phrase }
  project.goal           { rand(100000) }
  project.requestor      { Faker::Name.name }
  project.description    { "A good cause." }
  project.project_photos { [ Factory(:project_photo) ] }
end

Factory.define :donation do |donation|
  donation.association(:project)
  donation.association(:user)
  donation.amount { 100 }
  donation.transaction_id { "123abc" }
end

Factory.define :user do |user|
  user.email                 { Faker::Internet.email }
  user.password              { "password" }
  user.password_confirmation { "password" }
  user.first_name            { Faker::Name.first_name }
  user.last_name             { Faker::Name.last_name }
end

Factory.define :email_confirmed_user, :parent => :user do |user|
  user.email_confirmed { true }
end

Factory.define :organization_photo do |op|
end

Factory.define :project_photo do |pp|
  pp.file       { File.open(File.join(Rails.root, 'spec', 'fixtures', "orphanage_#{rand(3)}.jpg"))}
end
