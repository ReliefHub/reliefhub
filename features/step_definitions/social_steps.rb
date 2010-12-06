Then /^I should see the Facebook and Twitter share buttons$/ do
  page.should have_css("a.addthis_button_facebook_like")
  page.should have_css("a.addthis_button_tweet")
  page.should have_css("script[src*='addthis.com']")
end
