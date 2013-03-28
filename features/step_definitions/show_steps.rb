require_relative './util'

def create_dj
  create_visitor
  delete_user
  User.create @visitor.merge(:role => "dj")
end

Given /^the date is (\d+)\-(\d+)\-(\d+)$/ do |year, month, day|
  Timecop.travel(Date.new(year.to_i,month.to_i,day.to_i))
end

Given /^I am signed in as a user with the 'dj' role$/ do
  create_dj
  sign_in
end

When /^I create a new show$/ do
  visit '/shows/new'
  fill_in :show_title, with: "the modern sounds"
  select '2013', from: 'show_time_1i'
  select 'March', from: 'show_time_2i'
  select '30', from: 'show_time_3i'
  select '10', from: 'show_time_4i'
  select '00', from: 'show_time_5i'
  click_on 'submit'
end

Then /^I should see my show appear on the schedule$/ do
  visit '/schedule'
  page.should have_content 'Testy McUserton'
  page.should have_content 'the modern sounds'
end

Given /^a show exists$/ do
  create_dj unless User.first
  Show.create title: 'the modern sounds', user_id: User.first.id, time: Time.current
end

When /^I cancel my show$/ do
  visit "/shows/#{Show.first.id}/edit"
  click_on "Cancel show"
end

Then /^I should see my show appear as cancelled$/ do
  visit '/schedule'
  page.should_not have_content "the modern sounds"
end

When /^I edit my show's details$/ do
  visit "/shows/#{Show.first.id}/edit"
  fill_in :show_title, with: 'the not modern sounds'
  click_on 'submit'
end

Then /^I should see the show's details are updated$/ do
  visit '/schedule'
  page.should have_content "the not modern sounds"
end

When /^I visit '\/schedule'$/ do
  visit '/schedule'
end

Then /^I should see the list of upcoming broadcasts$/ do
  page.should have_content 'Testy McUserton'
  page.should have_content 'the modern sounds'
end
