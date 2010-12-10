Factory.define :organization do |organization|
  organization.name                { Faker::Company.name }
  organization.street1             { Faker::Address.street_address }
  organization.street2             { Faker::Address.secondary_address }
  organization.city                { Faker::Address.city }
  organization.state               { Faker::Address.us_state }
  organization.zip                 { Faker::Address.zip_code }
  organization.contact_person      { Faker::Name.name }
  organization.phone_number        { Faker::PhoneNumber.phone_number}
  organization.overview            { "The Mission des Eglises Baptistes Independantes (MEBI-NGO-HAITI) is a non-profit Christian institution which historically, as quite other institution, has made it through hard situations. MEBI – through her philisophy and visions, has intervened in several areas of activities. Her presence in the low northwest has brought hope to a population sunk into despair and neglect. MEBI founded in 1969 by the Reverend Leslie George Harris, a Jamaican missionary, who has been obedient to God’s call to be in Haiti since 1958 after his visit in 1957 together with a friend Wallace Turnbull- Father, in the low North-West of the country, a region known to be most difficult of the country. MEBI’s founder primary vision was to serve in four social areas : Religion - Agriculture – Education - and Health. However, due to lack in financial support and sound worries to remain faithful against corruption, MEBI has limited capacity to rank it among some big known NGOs. For more information please visit http://www.mebi-haiti.org/" }
  organization.organization_photos { [Factory(:organization_photo)] }
end

Factory.define :project do |project|
  project.association(:organization)
  project.name           { Faker::Company.catch_phrase }
  project.goal           { rand(1000) }
  project.requestor      { Faker::Name.name }
  project.description    { "This orphanage aims to provide underprivileged children with valuable trade and adult living skills. Plumbing, carpentry, electrical and computer repair skills are just some of the training that Hope For The Children Of Haiti, Inc. provides. Materials that will assist the children as they take these classes include basic accessories such as gloves, helmets, pliers and other tools common in welding and electrical work." }
  project.project_photos { [Factory(:project_photo)] }
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

Factory.define :organization_photo do |photo|
end

Factory.define :project_photo do |photo|
  photo.file { File.open(File.join(Rails.root, 'spec', 'fixtures', "orphanage_0.jpg")) }
end
