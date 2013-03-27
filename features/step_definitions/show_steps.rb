require_relative './util'

Given /^I am signed in as a user with the 'dj' role$/ do
  create_visitor
  delete_user
  User.create @visitor.merge(:role => "dj")
  sign_in
end

When /^I create a new show$/ do
  visit '/shows/new'
  fill_in :title, "the modern sounds"
  select
end

Then /^I should see my show appear on the schedule$/ do
    pending # express the regexp above with the code you wish you had
end

Given /^a show exists$/ do
    pending # express the regexp above with the code you wish you had
end

When /^I cancel my show$/ do
    pending # express the regexp above with the code you wish you had
end

Then /^I should see my show appear as cancelled$/ do
    pending # express the regexp above with the code you wish you had
end

When /^I edit my show's details$/ do
    pending # express the regexp above with the code you wish you had
end

Then /^I should see the show's details are updated$/ do
    pending # express the regexp above with the code you wish you had
end

When /^I visit '\/schedule'$/ do
    pending # express the regexp above with the code you wish you had
end

Then /^I should see the list of upcoming broadcasts$/ do
    pending # express the regexp above with the code you wish you had
end
