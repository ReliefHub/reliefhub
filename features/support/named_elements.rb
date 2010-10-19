module NamedElements
  # Accepts a named element (such as "the user info area") and returns a
  # selector to find that element on the page (such as "#user-info").
  def selector_for(named_element)
    case named_element
    when /the ReliefHub process/i
      '#process'
    when /featured project/i
      '#featured_wrap #featured_project'
    when /blog posts/i
      '#relief_blog'
    when /recent press/i
      '#recent_press'
    else
      raise %{No selector defined for an element with name "#{named_element}"\n} +
            "Check out features/support/named_elements.rb and add one"
    end
  end
end

World(NamedElements)
