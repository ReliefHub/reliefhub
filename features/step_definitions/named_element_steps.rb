When /^(?:|I )press ([^"].*)$/ do |named_element|
  locate(selector_for(named_element)).click
end

When /^(?:|I )follow ([^"].*)$/ do |named_element|
  link = selector_for(named_element)
  click_link(link)
end

When /^(?:|I )follow "([^\"]*)" within ([^"].*)$/ do |link, named_element|
  parent = selector_for(named_element)
  within(parent) do
    click_link(link)
  end
end

When /^(?:|I )select "([^\"]*)" from ([^"].*)$/ do |value, named_element|
  locate(selector_for(named_element)).select(value)
end

When /^(?:|I )check ([^"].*)$/ do |named_element|
  selector = selector_for(named_element)
  page.locate(selector).set('checked')
end

When /^(?:|I )uncheck ([^"].*)$/ do |named_element|
  selector = selector_for(named_element)
  page.locate(selector).set('')
end

When /^(?:|I )choose ([^"].*)$/ do |named_element|
  field = field_by_selector(selector_for(named_element))
  choose(field)
end

When /^(?:|I )choose "([^"]*)" within ([^"]*)?$/ do |field, named_selector|
  selector = selector_for(named_selector)
  with_scope(selector) do
    choose(field)
  end
end

Then /^(?:|I )should see "([^\"]*)" within ([^"].*)$/ do |text, named_element|
  selector = selector_for(named_element)
  within selector do
    page.should have_content(text)
  end
end

Then /^(?:|I )should see the value "([^\"]*)" in ([^"].*) field$/ do |text, named_element|
  selector = selector_for(named_element)
  page.locate(selector).value.should include(text)
end

Then /^(?:|I )should see ([^"].*) on the page$/ do |named_element|
  selector = selector_for(named_element)
  page.should have_css(selector)
end

Then /^(?:|I )should not see ([^"].*) on the page$/ do |named_element|
  selector = selector_for(named_element)
  page.should_not have_css(selector)
end

Then /^(?:|I )should not see "([^\"]*)" within ([^"].*)$/ do |text, named_element|
  selector = selector_for(named_element)
  within(selector) do
    page.should have_no_content(text)
  end
end

Then 'the page should not have $named_element' do |named_element|
  selector = selector_for(named_element)
  page.should have_no_css(selector)
end

Then /^the ([^"].*) field should contain "([^\"]*)"$/ do |named_element, value|
  field = selector_for(named_element)
  page.locate(field).value.should == value
end

Then /^the "([^\"]*)" field within ([^"].*) should contain "([^\"]*)"$/ do |named_element, named_selector, value|
  selector = selector_for(named_element)
  within(selector) do
    field = selector_for(named_element)
    page.locate(field).value.should == value
  end
end

Then /^the ([^"].*) field should not contain "([^\"]*)"$/ do |named_element, value|
  field = selector_for(named_element)
  if defined?(Spec::Rails::Matchers)
    field_by_selector(field).value.should_not =~ /#{value}/
  else
    assert_no_match(/#{value}/, field_labeled(field).value)
  end
end

When /^(?:|I )fill in ([^"].*) with "([^"]*)"$/ do |named_element, value|
  selector = selector_for(named_element)
  locate(selector).set(value)
end

Then /^the ([^"]*) checkbox should be checked$/ do |named_element|
  selector = selector_for(named_element)
  unless locate(selector)['checked']
    raise "Expected #{named_element} to be checked"
  end
end

Then /^the ([^"]*) checkbox should not be checked$/ do |named_element|
  selector = selector_for(named_element)
  if locate(selector)['checked']
    raise "Did not expect #{named_element} to be checked"
  end
end

Then /^([^"].*) should not be on the page$/ do |named_element|
  page.should have_no_css(selector_for(named_element))
end

Then /^([^"].*) should be on the page$/ do |named_element|
  page.should have_css(selector_for(named_element))
end

Then /^I should see "([^\"]*)" before "([^\"]*)" within ([^"].*)$/ do |first, second, named_element|
  first_expression  = Regexp.escape(first)
  second_expression = Regexp.escape(second)
  joint_expression  = /#{first_expression}.*#{second_expression}/m
  selector = selector_for(named_element)
  within(selector) do
    page.body.should =~ joint_expression
  end
end

When /^I press "([^\"]*)" within ([^"].*)$/ do |button, named_element|
  selector = selector_for(named_element)
  within selector do
    click_button button
  end
end

Then /^I should( not)? see the "([^"]*)" button within ([^"].*)$/ do |not_see,button_text,named_element|
  selector = selector_for(named_element)
  within selector do
    if not_see
      page.should_not have_button(button_text)
    else
      page.should have_button(button_text)
    end
  end
end

Then /^the ([^\"].*) should be (visible|hidden)$/ do |named_element, visibility|
  selector = selector_for(named_element)
  Then %(the "#{selector}" element should be #{visibility})
end

Then /^the ([^\"].*) should start out hidden$/ do |named_element|
  selector = selector_for(named_element)
  locate(selector).should_not be_visible
end

Then /^I should see the "([^\"]*)" brand badge as (unearned|earned) in ([^\"].*)$/ do |brand_name, state, badge_element|
  selector = selector_for(badge_element)
  brand = Brand.where(:name => brand_name).first or raise "No such brand: #{brand_name}"
  within selector do
    page.should have_css("#badge_brand_#{brand._id}.#{state}-badge")
  end
end

Then /^I should not see the "([^\"].*)" brand badge in ([^\"].*)$/ do |brand_name, badge_element|
  selector = selector_for(badge_element)
  brand = Brand.where(:name => brand_name).first or raise "No such brand: #{brand_name}"
  within selector do
    page.should have_no_css("#badge_brand_#{brand._id}")
  end
end

Then /^I should not see any links within (.*)$/ do |named_element|
  scope_selector = selector_for(named_element)
  page.should have_no_css("#{scope_selector} a[href]")
end

Then /^(.*) should have a loading indicator$/ do |named_element|
  selector = selector_for(named_element)
  locate(selector)['class'].should include('loading')
end

Then /^the ([^\"]+) button should be disabled$/ do |named_element|
  selector = selector_for(named_element)
  button = page.locate(selector).node
  raise "Expected #{named_element} button to be disabled" unless button['disabled']
end

Then /^the ([^\"]+) button should be enabled$/ do |named_element|
  selector = selector_for(named_element)
  button = page.locate(selector).node
  raise "Expected #{named_element} button to be enabled" if button['disabled']
end

Then /^there should be (\d+) pictures? within (.*)$/ do |count_string, named_element|
  selector = selector_for(named_element)
  images = page.locate(selector).node.children.select do |element|
             element.name == 'img'
           end
  images.count.should == count_string.to_i
end

Then %{I should see the following rows within $named_element:} do |named_element, table|
  selector = selector_for(named_element)
  table.diff!(tableish(selector, "th,td"))
end

Then %{I should see the following defined within $named_element:} do |named_element, table|
  table.raw.each do |dt, dd|
    dd_pattern = /#{Regexp.escape(dd).gsub('\ ', '\s+')}/m
    within(selector_for(named_element)) do
      page.should have_css("dt:contains('#{dt}') + dd", :text => dd_pattern)
    end
  end
end
