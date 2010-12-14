Then /^I should see the "([^"]*)" photo for the "([^"]*)" project$/ do |size, name|
  project   = Project.where(:name => name).first
  photo_src = project.photo_url(size.to_sym)
  page.should have_css("img[src='#{photo_src}']")
end

Given /^"([^"]*)" has a project photo$/ do |name|
  project   = Project.where(:name => name).first
  project.project_photos << Factory(:project_photo)
end

Then /^I should see a Google map image of "([^"]*)"'s address$/ do |name|
  organization = Organization.where(:name => name).first
  page.should have_css("img[src*='http://maps.google.com/maps/api/staticmap'][alt='#{organization.address}']")
end
