Given /^the following projects exist for organization "([^"]*)":$/ do |org_name, table|
  org = Organization.find_by_name org_name
  table.hashes.each do |project_name|
    Factory :project, :organization => org, :name => project_name
  end
end
