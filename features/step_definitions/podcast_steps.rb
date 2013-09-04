When(/^I create a podcast and fill in the user id$/) do
  visit new_podcast_path
  fill_in "podcast_title", with: "my cool podcast"
  select User.first.username, from: 'podcast_user_id'
  attach_file :podcast_mp3, File.expand_path("spec/fixtures/test.mp3")
  click_button "Submit"
end

Then(/^I should see that show in the podcasts$/) do
  visit podcasts_path
  page.should have_content("my cool podcast")
end

Given(/^some podcasts exist$/) do
  Podcast.create title: "my cool podcast", mp3: File.open("spec/fixtures/test.mp3")
end

When(/^I visit '\/podcast\.xml'$/) do
  visit "/podcasts.xml"
end

Then(/^I should get the podcast feed in xml format$/) do
  page.should have_content("my cool podcast")
  page.should have_content("test.mp3")
  page.should have_content("test.mp3")
end

When(/^I visit the podcast edit page and edit some details$/) do
  visit edit_podcast_path Podcast.first
  fill_in "podcast_title", with: "my new cool podcast"
  select User.first.username, from: 'podcast_user_id'
  attach_file :podcast_mp3, File.expand_path("spec/fixtures/test.mp3")
  click_button "Submit"
end

Then(/^I should see that updated show in the podcasts$/) do
  visit podcasts_path
  page.should have_content("my new cool podcast")
end
