module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /the "(.*)" static page/i
      page_path($1.gsub(" ", "_"))
    when /the sign up page/i
      new_user_registration_path
    when /the sign in page/i
      new_user_session_path
    when /the sign out page/i
      destroy_user_session_path
    when /the password reset request page/i
      new_user_password_path
    when /the admin organizations page/i
      admin_organizations_path
    when /the admin projects page for organization \"(.*)\"/i
      org = Organization.find_by_name $1
      admin_organization_projects_path(org.to_param)
    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
