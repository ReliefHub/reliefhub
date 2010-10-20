Factory.define :organization do |o|

end

Factory.define :project do |project|
  project.association(:organization)
  project.name        { Faker::Company.catch_phrase }
  project.goal        { rand(100000) }
  project.raised      { rand(10000) }
  project.orphanage   { Faker::Company.name }
  project.requestor   { Faker::Name.name }
  project.description { Faker::Lorem.paragraphs.join("\n") }
  project.photo       { File.read(File.join(Rails.root, 'spec', 'fixtures', "orphanage_#{rand(3)}.jpg"))}
end

Factory.define :user do |user|
  user.email                 { Faker::Internet.email }
  user.password              { "password" }
  user.password_confirmation { "password" }
end

Factory.define :email_confirmed_user, :parent => :user do |user|
  user.email_confirmed { true }
end

Factory.define :organization_photo do |op|
  
end

Factory.define :project_photo do |op|
  
end
